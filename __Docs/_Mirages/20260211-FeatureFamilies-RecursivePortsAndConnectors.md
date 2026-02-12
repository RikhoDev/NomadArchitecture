# Mirage — Feature Families: Recursive Ports & Connectors

```yaml
status: experimental
origin: human + ai (PhysicsVNext restructuring)
evidence: PhysicsVNext grew from 8 files to 20+ files with 6 distinct concerns,
          a 1034-line orchestrator, and a 40-property config where broadphase margins
          sit next to resting contact policy gates. Structure no longer communicates intent.
          The existing Ports & Connectors pattern already has the answer — apply it recursively.
```

> A feature that can no longer be understood in isolation
> is no longer sovereign — it's a confederation pretending to be a city.
> Give it the structure it's asking for.

---

## What This Mirage Is

A pattern extension for NomadArchitecture: **Feature Families**.

This mirage is also a clarification: a **Feature is a bounded capability**.

- The capability is the feature's internal engine (domain logic, invariants, tuning, algorithms).
- `_Ports/` and `_Connectors/` are **frontier passages**: contracts + adapters that allow the Host and neighbors to interact without seeing or depending on internals.

When a Feature's internal complexity grows beyond what a flat folder can communicate — multiple distinct algorithms, cross-cutting concerns, separate configuration surfaces — it needs internal structure. A Feature Family applies the Ports & Connectors pattern recursively: the family's frontier passages remain at the edge, while the capability is structured behind the boundary as named, sovereign sub-features. One connector often plays a wiring role by composing those sub-features into a pipeline.

This is not a new invention. It's the existing pattern recognizing that it scales downward, not just upward.

---

## The Problem: Features That Outgrow Themselves

A healthy Feature looks like this (capability first, frontier second, intent explicit):

```
KinematicMovement/
├── KinematicEngine.cs               ← the capability (the engine)
├── KinematicConfig.cs               ← feature-owned tuning (not automatically public)
├── _Ports/
│   └── IKinematicStep.cs            ← hourglass neck: what the Host is allowed to do
├── _Connectors/
│   └── KinematicMovement.cs         ← frontier passage: port implementation + wiring
└── README.md
```

Structure screams intent. A newcomer can read the folder and know what the feature does.

Important: `_Ports/` and `_Connectors/` are not “where the capability is.” They are the boundary: the passages that let a Host/neighbor speak to the feature without seeing its internals. The feature is the capability engine and the vocabulary it owns.

Naming guardrails (structure is storytelling):

- Avoid folders named `Internal/` (it hides intent; it is a visibility label, not a meaning label)
- Avoid bucket taxonomy like `Helpers/`, `Utils/`, or `Integrators/` unless the folder name is itself a stable phase/capability in the story
- Avoid `World` as a default noun for ports/connectors; it drifts toward a god-object and hides the promise
- Make intent unavoidable (e.g., say `Kinematic` if the promise is kinematic stepping)

Collocation guardrail (discoverability is affordability):

- If a language/type is private to one implementation, **declare it in the same file** as the implementation that uses it.
- If a language/type is private to the Feature but used by multiple files, keep it **at the feature root** (close to the capability engine) until it earns a more specific home.
- If that language/type is primarily owned by a phase/sub-feature, move it **into that phase folder together with the code that uses/implements it**.
- Avoid creating a `_Shared/` bucket: collocate by meaning and ownership, not by “sharedness”.

Where `Euler` fits (avoiding taxonomy):

- If Euler is the only integration method today, it should simply be an internal method or internal type inside the capability engine (`KinematicEngine`). No folder. No ceremony.
- If multiple integration methods become real, promote the axis explicitly (e.g., `Integration/Euler.cs`, `Integration/Verlet.cs`). Only then is `Integration/` a phase instead of a bucket.

But some features — physics engines, rendering pipelines, networking stacks — grow legitimately complex. They accumulate multiple algorithms, each with its own configuration surface, its own data structures, its own test surface. The flat folder stops communicating:

```
PhysicsVNext/                      ← 20+ files, one flat folder
├── _Ports/
├── _Connectors/
├── Broadphase.cs                  ← What phase? What depends on what?
├── Narrowphase.cs                 ← How does this relate to ContactManifold?
├── ConstraintSolver.cs            ← Which config knobs affect this?
├── RestingSupportSolver.cs        ← Is this the same solver or different?
├── ContactPolicy.cs               ← Policy for what? Applied where?
├── SupportPolygon.cs              ← Geometric helper? Solver input? Policy gate?
├── IslandSleepManager.cs          ← Where in the pipeline does this run?
├── ContactManifold.cs             ← Narrowphase output? Solver state? Both?
├── PhysicsMath.cs                 ← Used by everything
├── PhysicsStepRecorder.cs         ← Cross-cutting diagnostic
├── PhysicsVNextConfig.cs          ← 40 properties, 6 concerns
├── BodyId.cs, BodyState.cs, ...   ← Shared vocabulary
└── README.md
```

The structure no longer screams. It mumbles. A newcomer reading this folder cannot tell:
- Which files belong together
- Which pipeline phase each file serves
- Which config knobs affect which algorithm
- What depends on what

This is a **Worldview violation**: *"No dumping grounds: every file signals its intent."*

---

## The Solution: Feature Families

A **Feature Family** applies the Ports & Connectors pattern one level deeper:

```
PhysicsVNext/                          ← The Family
├── _Ports/                            ← Family-level API (what consumers see)
│   ├── IPhysicsWorldVNext.cs
│   ├── IPhysicsDebugViewVNext.cs
│   └── IPhysicsQueryVNext.cs
├── _Connectors/                       ← Frontier adapters; one is often the wiring passage
│   ├── PhysicsVNextWorld.cs           ← Implements the ports; composes sub-features into the step pipeline
│   └── PhysicsVNextRigidBodyAdapter.cs
│
├── BodyId.cs                          ← family-owned vocabulary (collocated at root if used across phases)
├── BodyState.cs
├── PhysicsStepResult.cs
├── ...
├── Geometry/                          ← Sub-feature: pure math, transforms, inertia
│   └── PhysicsMath.cs
│
├── Broadphase/                        ← Sub-feature: AABB overlap, pair generation
│   └── Broadphase.cs
│
├── Narrowphase/                       ← Sub-feature: SAT collision, contact generation
│   ├── Narrowphase.cs
│   └── ContactManifold.cs
│
├── Solver/                            ← Sub-feature: sequential impulse, reaction forces
│   ├── ConstraintSolver.cs
│   └── RestingSupportSolver.cs
│
├── ContactPolicy/                     ← Sub-feature: policy classification, support polygon
│   ├── ContactPolicy.cs
│   └── SupportPolygon.cs
│
├── Islands/                           ← Sub-feature: simulation islands, sleep state
│   └── IslandSleepManager.cs
│
├── Diagnostics/                       ← Sub-feature: timeline recording, snapshots
│   ├── PhysicsStepRecorder.cs
│   ├── PhysicsDebugSnapshot.cs
│   └── PhysicsContactDebug.cs
│
├── PhysicsVNextConfig.cs              ← Family config (composes sub-configs)
├── README.md
└── Map.md
```

Now the structure screams again. A newcomer can:
- See the pipeline stages as folders
- Understand what each sub-feature does from its name
- Find related files together
- Know where vocabulary lives: boundary language in `_Ports/` (or Core), private shared-within-family language collocated at root or inside the owning phase
- Know that `_Connectors/PhysicsVNextWorld.cs` is the wiring passage (not “the capability”)

---

## The Axioms

### Axiom 1: A Feature Family is a Feature whose internal domain logic is itself structured as sovereign sub-features

The family presents a unified API through its own `_Ports/`. Consumers never see sub-features. The family boundary is the contract.

### Axiom 2: The family's Connectors are frontier passages; one often provides pipeline wiring

Just as a Host wires Features, a family connector composes sub-features. It may own the pipeline — the sequence in which sub-features execute — but it should not *be* the capability. Capability should remain in named internal modules; the connector stays a passage: adaptation + wiring + lifecycle.

### Axiom 3: Sub-features communicate through shared vocabulary, never through each other's internals

Sub-features must share a vocabulary — identity types (BodyId, ShapeId), state types (BodyState), result types (PhysicsStepResult) — but that vocabulary remains **feature-owned** and follows **collocation**.

- If a type must cross the family boundary, it belongs in `_Ports/` (or in higher-level Ports/Core).
- If a type is private to one implementation, collocate it in the same file.
- If a type is private to the family and used across phases, keep it at the family root (near the capability engine) until it earns a phase home.
- If a type is primarily owned by one phase, place it in that phase folder next to the code that uses/implements it.

### Axiom 4: Sub-features may have their own Ports if substitution is meaningful

A physics broadphase could be an AABB sweep, a spatial hash, or a BVH tree. If the algorithm is genuinely substitutable, the sub-feature earns its own `_Ports/` (and possibly `_Connectors/`). If it's single-implementation, the concrete type is the contract — no interface needed. Avoid internal ceremony that turns the family into a bureaucracy.

### Axiom 5: Stop nesting when sub-features fit in one reader's head

Feature Families do not become clans unless sub-features themselves outgrow single-folder comprehension. The stopping rule is cognitive: **if a sub-feature can be understood by reading its folder, it doesn't need internal structure.** A 500-line narrowphase is serious code but single-concern. It doesn't need sub-sub-features.

---

## When to Apply

A Feature needs to become a Family when:

1. **Multiple distinct pipeline stages** with different data flow patterns
2. **Config surface exceeds ~15 properties** spanning unrelated concerns
3. **A newcomer cannot tell which files relate** to which phase or concern
4. **Bucket folders appear** as coping mechanisms (`Internal/`, `Helpers/`, `Integrators/`)
5. **Test surfaces naturally cluster** around sub-components (broadphase tests vs. solver tests vs. sleep tests)
6. **The orchestrator exceeds ~500 lines** because it inlines multiple phases

A Feature should **NOT** become a Family when:

1. It has many files but they all serve one concern (e.g., a rendering feature with many shader helpers)
2. The complexity is in one deep algorithm, not in pipeline composition
3. The config is large but all properties interact (splitting would hide coupling)
4. Adding structure costs more clarity than it gains

---

## When a Family Becomes a Clan

A **Clan** is a family of families. It exists when:

1. Sub-features themselves outgrow single-folder comprehension
2. Multiple levels of orchestration are needed
3. The pipeline has branches, not just a sequence

Example: if PhysicsVNext later adds sphere/capsule/mesh collision, the Narrowphase sub-feature might need internal structure for each geometry pair. Or if it adds joints, springs, and motors alongside contacts, the Solver becomes a family of constraint types.

Until that complexity is real and present, clans are speculation. **Chase what the codebase asks for.**

---

## Relationship to Existing Patterns

| Concept | Workspace Level | Family Level |
|---------|----------------|--------------|
| Shared contracts | `Core/` | `_Ports/` types (if crossing boundary); otherwise private vocabulary at family root |
| Autonomous capability | `Features/` folder | Sub-feature folder |
| Integration surface | `_Connectors/` (boundary adapters) | `_Connectors/` (boundary adapters; one may be micro-Host wiring) |
| Wiring point | `Hosts/` | Family wiring passage in `_Connectors/` |
| Consumer API | Feature `_Ports/` | Family `_Ports/` |

The same principles, the same mechanics, the same underscore conventions. Feature Families are not an extension of NomadArchitecture — they are NomadArchitecture recognizing its own fractal nature.

---

## Origin Evidence

PhysicsVNext in NomadGameEngine:
- **Before**: 20+ files in a flat folder, 1034-line orchestrator, 40-property config spanning broadphase margins, solver iterations, sleep thresholds, resting policy gates, per-contact impulse clamps, and force-based limiters
- **Trigger**: Adding resting contact policy, support polygon analysis, and analytical reaction solver pushed the feature past the comprehension threshold
- **After**: 7 sub-features, each in its own folder, with a thinned orchestrator that delegates to named phases

The pattern emerged from real need, not from prediction.

---

## What This Mirage Does NOT Cover

- **Clan mechanics** (family of families) — speculative, not yet needed
- **Sub-feature Ports protocol** — when and how sub-features expose their own `_Ports/` is left to judgment
- **Config composition** — whether the family config decomposes into sub-configs or stays flat with grouped sections is an implementation decision, not a structural axiom
- **Compiler-enforced boundaries** — whether you split features into separate assemblies or use analyzers to prevent boundary leaks is a separate governance choice
- **Cross-family communication** — families communicate with other features through the same Core contracts as regular features

---

## Status

This mirage was born from restructuring PhysicsVNext in NomadGameEngine on 2026-02-11.
It will graduate from mirage when a second Feature Family emerges independently and confirms the pattern holds.
