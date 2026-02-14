# Mirage — Editor Genesis: The Portable Engine Session

```yaml
status: experimental
origin: human + ai (Editor planning grounded in codebase analysis)
evidence: GameRuntime.cs is 590 lines of monolithic bootstrapping that hardwires
          Raylib, shadow pipeline setup, lighting showcase hacks, game detection
          heuristics, and DI registration all in one Initialize() method.
          The Editor cannot embed it. But the layers underneath — Scene, RenderPipeline,
          RuntimeOrchestrator, ServiceResolver — are already portable.
          The bootstrapper pattern proven by RunAndGunRuntimeBootstrapper and
          CubePlaygroundHostBootstrapper already shows how to compose a host
          without copying GameRuntime. The missing piece is a shared abstraction.
```

> Do we really want to rewire everything like the runtime itself does
> if we want integrated live preview of the scene and gizmos?
>
> No. The question reveals the real problem:
> GameRuntime is not a reusable engine core — it's a monolithic host
> pretending to be one. Extract the portable half, and the Editor
> becomes just another thin host with a different phase composition.

---

## What This Mirage Is

A grounded plan for building an Editor host by first extracting a portable engine core (`EngineSession`) that any host — Runtime, Editor, SnakeHost, future game hosts — can embed. Based on a deep reading of the actual codebase, not aspirational architecture.

---

## The Structural Reality

### What Is Already Portable (zero Raylib dependency)

| Layer | Key Files | Verdict |
|-------|-----------|---------|
| Scene / SceneManager / GameObject | `src/Features/Scene/` | Clean — zero Raylib imports |
| RenderPipeline + RenderPass | `src/Features/Rendering/Pipeline/` | Clean — pass-based, composable, Raylib lives in individual pass implementations only |
| IGamePhase / IGameLoop | `src/Features/Hosting/GameLoop/_Contracts/` | Clean ports |
| RuntimeOrchestrator | `src/Features/Hosting/PluginSystem/` | Clean — DI + reflection-based system loading |
| ServiceResolver | `src/Foundations/Dependency/` | Clean — ConcurrentDictionary-backed, minimal |
| GameConfig | `src/Features/Hosting/PluginSystem/` | Clean — has phase-gating booleans (EnablePhysics, EnableRendering, etc.) |
| PhaseFactory pattern | RunAndGun + CubePlayground `_Connectors/` | Mostly clean — pattern is sound, but each factory's render phase is Raylib-coupled |

### Where Raylib Leaks Beyond `_Connectors` (the 3 seal points)

| What | Where | Problem |
|------|-------|---------|
| `FixedTimestepGameLoop` | `Features/Hosting/GameLoop/_Connectors/` | Calls `Raylib.WindowShouldClose()`, `Raylib.GetFrameTime()`, `Raylib.BeginDrawing()` directly |
| `ICameraStrategy` | `Hosts/Runtime/Features/Camera/` | Port takes `ref Raylib_cs.Camera3D` — leaks Raylib type into interface contract |
| `IRenderingUtilities` | `Features/Rendering/` | Interface returns `Raylib_cs.Color` — pollutes the port contract |
| `GpuLitMaterial` | `Features/Rendering/Materials/` | Holds `Raylib_cs.Shader` as a field in core material code |

### The Existing Bootstrapper Pattern (proof it works)

Both `RunAndGunRuntimeBootstrapper.Bootstrap()` and `CubePlaygroundHostBootstrapper.Bootstrap()` follow the same shape:

1. Take `GameConfig` + `IServiceResolver` + `IWindow` + `IGraphicsDevice`
2. Register ports on the resolver
3. Call `RuntimeOrchestrator.Orchestrate()` to instantiate systems
4. Create a `PhaseBundle` via a game-specific `PhaseFactory`
5. Return a `BootstrapResult` with `SceneManager` + `IGameLoop`

The Runtime host (`GameRuntime`) does not follow this pattern — it inlines everything. The Editor should follow the bootstrapper pattern, not the Runtime pattern.

### Host Duplication

`RuntimeGameLoop` (in `Hosts/Runtime/`) and `FixedTimestepGameLoop` (in `Features/Hosting/GameLoop/_Connectors/`) are near-duplicates. Both hardcode Raylib calls. This duplication is a symptom of `GameRuntime` not using the shared infrastructure.

---

## The Plan — Grounded in Code

### Phase 0: Seal the Raylib Leaks (3 surgical changes)

These are not refactors. They are type replacements at interface boundaries.

1. **`FixedTimestepGameLoop`** — extract `Raylib.WindowShouldClose()` → `IWindow.ShouldClose()` (port already exists), `Raylib.GetFrameTime()` → `ITimeSource.GetDelta()` (new micro-port), `Raylib.BeginDrawing()` → `IDrawContext.BeginFrame()` (new micro-port).

2. **`ICameraStrategy`** — change `ref Camera3D` → engine-owned camera struct. `Features/Rendering/Camera/Camera.cs` already exists with view/projection matrices.

3. **`IRenderingUtilities`** — replace `Raylib_cs.Color` with `SampleGameEngine.Core.Color` (already exists in the codebase).

After this, the game loop and phase infrastructure becomes backend-agnostic.

### Phase 1: Extract `EngineSession` (the portable runtime core)

`GameRuntime.Initialize()` does two jobs tangled together:
- **Platform init** (Raylib window, device, input) — host-specific, stays in host
- **Engine core setup** (scene, physics, DI, systems, pipeline, phases) — portable, extracted

The extraction target:

```csharp
// src/Features/Hosting/EngineSession/EngineSession.cs
public class EngineSession : IDisposable
{
    public SceneManager SceneManager { get; }
    public IServiceResolver Resolver { get; }
    public RenderPipeline RenderPipeline { get; }
    public PhysicsWorld PhysicsWorld { get; }
    public IGameLoop GameLoop { get; }

    public static EngineSession Create(
        GameConfig config,
        IWindow window,
        IGraphicsDevice graphics,
        IInputProvider input,
        Func<SystemManager, PhaseBundle> phaseFactory)
    {
        // DI registration, system instantiation, pipeline pass setup,
        // scene creation — all moved from GameRuntime.Initialize()
    }

    public void RunFrame(float deltaTime) => GameLoop.RunFrame(SceneManager);
}
```

Hosts collapse to their true shape — thin shells:

```csharp
// Runtime host — ~30 lines
var window = new RaylibWindow(...);
var graphics = new RaylibDevice();
var input = new RaylibInputProvider();
var session = EngineSession.Create(config, window, graphics, input, RuntimePhaseFactory.Create);
session.GameLoop.Run(session.SceneManager);
```

```csharp
// Editor host — same session, different loop control
var session = EngineSession.Create(config, window, graphics, input, EditorPhaseFactory.Create);
while (!shouldClose)
{
    session.RunFrame(deltaTime);
    DrawEditorUI();  // ImGui panels around the viewport
}
```

### Phase 2: Editor Host (leverages EngineSession)

With `EngineSession` extracted, the Editor does not rewire anything. It:

1. Creates the same `RaylibWindow` + `RaylibDevice` the Runtime uses
2. Passes an `EditorPhaseFactory` that:
   - **Reuses** `RuntimeUpdatePhase`, `RuntimePhysicsPhase`
   - Swaps the render phase for `EditorRenderPhase` (renders to viewport sub-region, not fullscreen)
   - Adds editor-only gizmo drawing after the scene render
3. Calls `session.RunFrame()` manually each frame (does not surrender to `IGameLoop.Run()`)
4. Draws specific UI panels (Hierarchy, Inspector, Scene View) using the UI foundations and features **around** the engine viewport
5. The live preview is literally the same render pipeline rendering to a sub-region — no rewiring

The existing `EditorApplication.cs` skeleton (window classes: Hierarchy, Inspector, SceneView, Project, Console) provides the starting structure. The skeleton has no Raylib imports and no functional bodies — ready to implement on top of `EngineSession`.

### Phase 3: Scene Serialization (unblocks save/load for both hosts)

`SceneManager.LoadSceneAsync()` body is `await Task.Delay(1)` + placeholder comment. `DefaultSceneLoader` is a stub. Implement JSON round-trip so:
- Editor can save authored scenes
- Runtime can load them (replacing `// TODO: Load scene from file` at GameRuntime.cs line 157)
- Tests can use data-driven scene fixtures

---

## What We Are NOT Doing (and why)

| Item | Reason to skip |
|------|----------------|
| Undo/redo system | Premature — need a working editor first |
| Custom gizmo framework | `Raylib_cs` has `DrawLine3D`, `DrawSphere` — sufficient for MVP |
| CI pipeline for Editor | No artifact to test yet |
| Object picking | Needs `Camera.ScreenToWorldPoint()` — implement when viewport exists |
| ImGui integration from scratch | Already used in `DebugOverlayHost` / `LightingOverlay` — extend, don't rebuild |

---

## Dependency Shape

```
┌──────────────────────────────────────┐
│  Hosts (thin shells)                 │
│  ├─ Runtime       (→ EngineSession)  │
│  ├─ Editor        (→ EngineSession)  │
│  ├─ SnakeHost     (→ EngineSession)  │
│  └─ RunAndGunHost (→ EngineSession)  │
├────────── HOURGLASS WAIST ───────────┤
│  EngineSession (portable core)       │
│  ├─ SceneManager                     │
│  ├─ PhysicsWorld                     │
│  ├─ RenderPipeline                   │
│  ├─ RuntimeOrchestrator              │
│  └─ ServiceResolver                  │
├──────────────────────────────────────┤
│  Platform Connectors                 │
│  ├─ RaylibWindow      (IWindow)      │
│  ├─ RaylibDevice      (IGraphicsDevice)│
│  └─ RaylibInputProvider (IInputProvider)│
└──────────────────────────────────────┘
```

Each host chooses:
- Which platform connectors to plug in (Raylib today, something else tomorrow)
- Which `PhaseFactory` to use (game-specific phases vs editor phases)
- Whether to drive the loop (`Run()`) or step it manually (`RunFrame()`)

---

## Key Insight

The architecture documentation (`HOSTS-ARCHITECTURE.md`) already describes two host patterns: thin (hardcoded) and plugin-based (config-driven). The Editor is a **third pattern**: interactive host with manual frame control. All three share the same engine core — the code just hasn't been extracted yet.

The bootstrapper pattern (`RunAndGunRuntimeBootstrapper`, `CubePlaygroundHostBootstrapper`) is the proof that this extraction works. `EngineSession` is that pattern elevated to a first-class shared abstraction.
