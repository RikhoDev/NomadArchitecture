# Mirage — NomadGameEngine Architecture Upgrade Path

```yaml
status: experimental
origin: human + ai (assessment-driven)
evidence: Full architecture assessment of NomadGameEngine on 2026-02-09.
          Dependency graph is clean. Cultural practices are present but uneven.
          Specific structural weaknesses identified and prioritized below.
```

> The fire is real. The pillars stand. The dependency graph is honest.
> But the tent fabric is stitched in one piece where it should be panels —
> and some things are sleeping in the wrong beds.

---

## What This Mirage Is

A prioritized upgrade path for NomadGameEngine, born from a full Worldview-grounded assessment. Each proposal is tagged with effort, impact, and sequencing dependencies. Nothing here is canon until it's done and proven.

This is a planning document, not a commitment. Chase what the codebase asks for. Turn away from what feels forced.

---

## The Three Systemic Issues

These are the roots. Everything else is a symptom.

### 1. The Mono-Csproj Problem

**What:** `Features.csproj` compiles all 16 features as one assembly. `Foundations.csproj` does the same for 13 foundations. Feature sovereignty is a convention enforced by discipline, not by the compiler.

**Why it matters:** Cross-feature `using` statements cost nothing. Scene is coupled to 7 features. Gameplay imports 8. Raylib-cs bleeds into Logging. The architecture says "sovereign" but the compiler says "one blob." A newcomer can violate sovereignty without knowing it — no error, no warning, just silent coupling.

**The upgrade:**

```
Before:
  src/Features/Features.csproj  →  1 assembly, 16 features

After:
  src/Features/Rendering/Rendering.csproj
  src/Features/PhysicsVNext/PhysicsVNext.csproj
  src/Features/Commands/Commands.csproj
  src/Features/Input/Input.csproj
  src/Features/Scene/Scene.csproj
  src/Features/Gameplay/Gameplay.csproj
  ...
```

**Sequencing:**
- Phase A: Split the most active features first (Rendering, PhysicsVNext, Commands)
- Phase B: Split Foundations (Graphics + Platform get their own csproj with Raylib/Silk.NET; the rest stay clean)
- Phase C: Split remaining features as they earn it

**Risk:** Circular dependencies will surface. Scene depends on Rendering depends on Scene is the likeliest. Resolve by extracting shared contracts into Core or a new `Features.Contracts` project.

**Effort:** Medium-high. Requires careful dependency untangling.
**Impact:** Highest. Makes sovereignty a compiler guarantee, not a hope.

---

### 2. Core Is Not Minimal

**What:** Core has 31 types across 17 files. The Worldview says "smallest set of rules." Three categories of debris live here:

| Debris | Types | Belongs In |
|--------|-------|------------|
| Config creep | `GameConfig` (with `GameName = "Snake"`), `VehiclePhysicsConfig`, `ShadowConfig`, `CameraConfig`, `InputConfig`, `VehicleInputConfig` | Each Feature owns its own config |
| Feature ports | `ObjectGenerationPorts.cs` (`ISpawner`, `IObjectPopulator`, `IScenePopulationContext`) | `Features/_Contracts/` |
| Concrete ECS | `World.cs` (concrete `ConcurrentDictionary` container) | `Foundations/ECS` or stays as pragmatic exception |

**The upgrade:**
1. Move `GameConfig` nested configs to their Features. `GameConfig` itself becomes a thin shell or disappears.
2. Move `VehicleInputConfig` to `Features/Input/` or `Features/Gameplay/VehiclePhysics/`.
3. Move `ObjectGenerationPorts` to `Features/_Contracts/ObjectGeneration/`.
4. Decide: is `World.cs` a contract or an implementation? If implementation, extract `IWorld` interface into Core, move implementation to Foundations.

**After cleanup, Core would hold ~12 types in ~8 files.** Genuinely minimal.

**Effort:** Low-medium. No new infrastructure — just moving files and updating namespaces.
**Impact:** High. Restores Core's promise: "these are the rules, nothing more."

---

### 3. The Identity Split

**What:** The repo is called `NomadGameEngine`. The solution is `NomadGameEngine.slnx`. Every C# namespace says `SampleGameEngine`. The root README says `# SampleGameEngine`. Test projects say `NomadGameEngine.Tests`.

**Why it matters:** "Names are promises." These promises contradict each other. A newcomer doesn't know which name is real. The Worldview says naming is narrative — this narrative stutters.

**The upgrade:**
- Pick one: `NomadGameEngine` (the repo identity) or `SampleGameEngine` (the original). The repo has moved past "sample" — it has 15 features, 10+ hosts, 48+ tests just for rendering. It's an engine.
- Rename the root namespace. `dotnet format` + find-and-replace across all `.cs` files.
- Update README, docs, and any string literals.

**Effort:** Low (mechanical rename), medium (testing all references).
**Impact:** Medium. Fixes the identity stutter. Makes the name honest.

---

## Structural Upgrades (Ordered by Leverage)

### 4. Migrate ObjectGeneration Out of Foundations

**What:** `Foundations/ObjectGeneration/` contains `WallSpawnerLogic`, `RandomWallPopulator`, `WallSpawnerConfig` — gameplay domain logic with physics properties (mass, kinematic flags, cube sizes). This is not a "hardened technical adapter."

**Where it goes:** `Features/Gameplay/_Connectors/Spawning/` or a new `Features/ObjectGeneration/`.

**Effort:** Low. Move files, update namespaces, fix any `using` statements.
**Impact:** Medium. Restores Foundations' promise: "technology-facing, not domain-facing."

---

### 5. Resolve the Runtime Host

**What:** `src/Hosts/Runtime/` contains:
- A local `Features/` subdirectory (Camera strategies, Rendering utilities, UI overlays)
- `Systems/` with hardcoded game systems (`SnakeGameSystem.cs`, `RunAndGunInitSystem.cs`)
- `SimpleLightingSystem.cs` (66 lines of lighting domain logic)
- A `_Roof/HostRendering.cs` that duplicates the pillar-level `_Roof/` with different implementation

**Options:**
- **(a) Extract** — move the Feature-like code into actual Features and make Runtime a thin host like SnakeHost
- **(b) Accept** — document Runtime as an intentionally thick "development harness" host, distinct from the thin-host pattern. Honest divergence from the pattern.
- **(c) Archive** — if Runtime is being superseded by specific hosts (CubePlayground, RunAndGun, Snake), archive it like the `_Archive/Runtime` that already exists

**Effort:** Medium (option a), low (option b).
**Impact:** Medium. Cleans up the most violated host.

---

### 6. Gameplay as a Pillar Question

**What:** `Features/Gameplay/` contains `CubePlayground`, `RunAndGun`, `SnakeGame` — these are game-specific compositions that wire 8+ features together. They are not sovereign capabilities. By the Worldview's definition, they fail the isolation test.

**The deeper question:** Are these Features, or are they Hosts that happen to live in the wrong pillar?

**Options:**
- **(a)** Move game-specific compositions to their Hosts (SnakeGame logic → SnakeHost, RunAndGun logic → RunAndGunHost). Keep shared gameplay mechanics (Movement, VehiclePhysics) in Features.
- **(b)** Accept Gameplay as a "composition Feature" — a recognized pattern where the Feature's sovereignty is expressed at the game-design level, not the technical level. Document the exception.

**Effort:** Medium (option a — many files to move), low (option b — document the decision).
**Impact:** Medium-high. Resolves the feature-vs-host confusion for the most cross-cutting directory.

---

### 7. Hosting → Foundations

**What:** `Features/Hosting/` contains `GameLoop/` (RuntimeOrchestrator, PhaseExecutor, SystemManager) and `PluginSystem/`. These are runtime mechanisms, not domain capabilities. The GameLoop subdirectory has 13+ files and zero documentation.

**The upgrade:** Move to `Foundations/Runtime/` or `Foundations/Hosting/`. These are technology-facing mechanisms that multiple hosts consume — exactly what Foundations is for.

**Effort:** Low-medium.
**Impact:** Medium. Features stays focused on domain capabilities.

---

### 8. Canonize or Retire `_Roof` and `_Phases`

**What:** `_Roof/` and `_Phases/` extend the underscore grammar without appearing in the Worldview. `_Roof` appears at pillar level AND inside Runtime with **different implementations** — one delegates to a `_Connector`, the other has inline Raylib calls.

**Options:**
- **(a)** Add `_Roof` and `_Phases` to the NomadArchitecture Worldview as recognized grammar
- **(b)** Replace with canonical names: `_Roof` → `_Shared` or `_Common`; `_Phases` → stays inside the host that owns it without underscore prefix

**Effort:** Trivial.
**Impact:** Low. But naming hygiene compounds over time.

---

## Hygiene Upgrades

### 9. Centralize Test Infrastructure Versions

**What:** xUnit spans 3 versions (2.5.0 → 2.9.2), `Microsoft.NET.Test.Sdk` spans 3 versions (17.9.0 → 18.0.0), `System.Drawing.Common` spans 3 versions. `xunit.runner.visualstudio` spans 4 versions.

**The upgrade:** Add a `Directory.Packages.props` at root with centralized version management. Each test `.csproj` references packages without versions — the props file governs.

**Effort:** Low.
**Impact:** Low-medium. Prevents version drift from becoming version conflict.

---

### 10. Remove `ITexture.TryGetRaylibTexture2D` from Graphics Contract

**What:** The `IGraphicsDevice` abstraction in Foundations/Graphics has `TryGetRaylibTexture2D` on the `ITexture` interface — a method that names a specific backend in a backend-neutral contract.

**The upgrade:** Move to a Raylib-specific extension method or a downcast pattern. The interface stays clean.

**Effort:** Low.
**Impact:** Low. But contract purity matters for the next backend.

---

### 11. Trail Coverage

**What:** Only 16% of features have trail documents. Only 1 TRAIL.md exists in the entire `src/` tree. The Worldview says "Every Feature carries README (why), Map (how), Traces (what happened)."

**The upgrade:** Add Map.md to the 5 most active features that lack them:
- `Features/Commands/` (has ARCHITECTURE.md but no Map.md)
- `Features/Rendering/` (has Map.md ✓)
- `Features/Gameplay/CubePlayground/`
- `Features/Input/`
- `Features/Scene/`

Don't fabricate trails for dormant features. Honest absence is better than fictional presence.

**Effort:** Medium (research + writing per feature).
**Impact:** Medium. Trails are the substrate of reflection.

---

## Sequencing Proposal

If this mirage becomes a plan, here's one ordering that respects dependencies:

```
Phase 0 — Quick wins (1-2 days)
  ├── Migrate Core debris (#2)
  ├── Migrate ObjectGeneration from Foundations (#4)
  ├── Canonize or retire _Roof/_Phases (#8)
  ├── Centralize test versions (#9)
  └── Remove TryGetRaylibTexture2D (#10)

Phase 1 — Identity (1 day)
  └── Namespace rename SampleGameEngine → NomadGameEngine (#3)

Phase 2 — Sovereignty (3-5 days)
  ├── Split Features.csproj into per-feature projects (#1, Phase A)
  ├── Split Foundations.csproj for GPU isolation (#1, Phase B)
  └── Resolve circular dependencies that surface

Phase 3 — Structural clarity (2-3 days)
  ├── Resolve Runtime host (#5)
  ├── Decide Gameplay's identity (#6)
  ├── Move Hosting to Foundations (#7)
  └── Add trail documents (#11)
```

---

## What Would Success Look Like?

- `dotnet build Features/Rendering/Rendering.csproj` works in isolation
- Core has ≤15 types, all contracts or value types
- The namespace says `NomadGameEngine` everywhere
- No domain logic in Foundations
- A newcomer opening the repo sees one name, one structure, one clear path in
- The compiler catches sovereignty violations before a human has to

---

## The Tension to Hold

The Worldview warns: "Seed vs. Doctrine — both are necessary." Some of these upgrades are doctrine (enforce what we believe). Others are premature (the codebase hasn't asked for them yet).

**Chase what the codebase asks for.** If Feature coupling burns you during a sprint, that's the codebase asking for per-feature csproj splits. If it doesn't burn, maybe the mono-csproj is fine for now.

**The one exception:** the namespace rename. That's not something the codebase will ask for — it's something the identity demands. Names are promises, and right now the promise stutters.

---

*This mirage was born from a full architecture assessment grounded in the Worldview.*
*It is speculative. It is required to be honest about what it knows and doesn't know.*
*Chase what shimmers. Turn away from what feels forced.*
