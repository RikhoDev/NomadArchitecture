# Structure Is Communication

**Canon Principle of NomadArchitecture**

> In NomadArchitecture, folder structure is not where things live—it is how things speak.

---

## The Principle

```
Traditional Architecture:          NomadArchitecture:

Documentation explains code    →    Structure explains itself
Folders organize files        →    Folders declare intent
Names are labels              →    Names are contracts
Structure is hidden           →    Structure is visible
Change = incompatibility      →    Change = decision + trail
```

### The Law

**Structure communicates identity, intent, and relationships without prose.**

When you navigate a NomadArchitecture codebase, the folder tree answers:
- What does this unit need? → Look at `_Ports/`
- What implementations exist? → Look at `_Connectors/`
- What is this unit's core? → Look at its `_Ports/`
- How are units composed? → Look at nesting depth

### The Corollary

**Internal choices are free, as long as the trails remain visible.**

The boundary (structure) is sacred—`_Ports/` declares the contract.

The internals are flexible—implementation can evolve, optimize, refactor—as long as decisions are documented and discoverable. The `_Chronicles/` folder records why choices were made, enabling future developers (and future you) to understand the evolution without losing context.

---

## Stability and Flexibility

### External Contract (Sacred)

```
Features/Physics/_Ports/IPhysicsTraceCollector.cs
```

This is **written in stone**. If you change it, you're breaking the contract. Other Features depend on this interface.

**Structure here is rigid because communication depends on it.**

### Internal Implementation (Free)

```
Features/Physics/_Connectors/
├── LazyFormattingPhysicsTracer.cs  ← Change freely
├── NullPhysicsTracer.cs            ← Optimize freely
└── HighPerformancePhysicsTracer.cs ← Add freely
```

These can evolve, be replaced, optimized, refactored, without changing the contract.

**Structure here is flexible because only the boundary matters.**

### Decisions (Documented)

```
Features/Physics/
├── _Ports/
├── _Connectors/
└── _Chronicles/                  ← Why did we make these choices?
    ├── 2026-01-15-trace-performance-analysis.md
    ├── 2026-01-20-null-tracer-decision.md
    └── 2026-01-25-lazy-formatting-rationale.md
```

**When you change internals, leave a trail.**

---

## The Trail: Accountability Through Documentation

### The Problem It Solves

**Without Trails:**
```
// Why did we do this?
public class LazyFormattingPhysicsTracer { ... }
// Nobody knows. Future devs guess. Time wasted.
```

**With Trails:**
```
Features/Physics/_Chronicles/2026-01-25-lazy-formatting-rationale.md:

## Decision: Lazy-Formatting Tracer

When: 2026-01-25
Why: Profiling showed 36,000 string allocations/sec in trace path
      Eager .ToString() happens before method dispatch check
      Lazy formatting reduces production allocs to zero
How: Check RuntimeTrace.Enabled flag before formatting
Status: Production, zero overhead
```

### Three Levels of Choice

| Level | Location | Freedom | Rule |
|-------|----------|---------|------|
| **Contract** | `_Ports/` | Sacred | Change = breaking contract |
| **Implementation** | `_Connectors/` | Free | Change = leave trail |
| **Optimization** | Inside `_Connectors/` | Free | Change = leave trail |

---

This document lives at:
```
__Docs__/Concepts/StructureIsCommunication.md
```

Its location declares:
- `__Docs__/` → Documentation (discovery)
- `Concepts/` → Foundational principle (canon)
- `StructureIsCommunication.md` → The specific principle (identity)

**You didn't need to read this section to know what this document is.** Its path told you.

---

## Examples

### Example 1: Declaring Dependencies

**Without Structure:**
```csharp
// Physics needs some way to trace execution for debugging
// We use RuntimeTrace for now but might change later
// See documentation for how tracing works
public class PhysicsWorld { ... }
```
*Intent hidden in comments. Dependency not discoverable.*

**With Structure:**
```
Features/Physics/
└── _Ports/
    └── IPhysicsTraceCollector.cs
```
*Intent visible in folder. Dependency declared at boundary.*

### Example 2: Finding Implementations

**Without Structure:**
```
src/physics/tracers/lazy.cs
src/physics/tracers/null.cs
src/logging/trace.cs
```
*Are these related? Which are implementations vs infrastructure?*

**With Structure:**
```
Features/Physics/
├── _Ports/
│   └── IPhysicsTraceCollector.cs
└── _Connectors/
    ├── LazyFormattingPhysicsTracer.cs
    └── NullPhysicsTracer.cs
```
*Relationship clear. Port declares, Connectors implement.*

### Example 3: Understanding Sovereignty

**Without Structure:**
```
FluidDynamics references Physics
Is it a child? A sibling? A dependency?
```

**With Structure:**
```
Features/Physics/
└── FluidDynamics/
    └── _Ports/
        └── IFluidObserver.cs
```
*FluidDynamics is a child of Physics. It has its own sovereignty (its own _Ports).*

---

## The Pattern in Practice

### Documentation Through Folders

```
Features/
├── Physics/               # "I am Physics"
│   ├── _Ports/           # "I declare these contracts"
│   ├── _Connectors/      # "I provide these implementations"
│   └── Dynamics/         # "I contain this implementation"
│
└── Rendering/            # "I am Rendering"
    ├── _Ports/           # "I declare these contracts"
    ├── _Connectors/      # "I provide these implementations"
    └── Pipelines/        # "I contain this implementation"
```

**Each folder answers a question:**
- **What?** → Folder name (Physics, Rendering)
- **Contract?** → `_Ports/` content
- **Implementation?** → `_Connectors/` content
- **Structure?** → Nesting depth

### Titles Become Folders

When documenting NomadArchitecture:

**Anti-pattern (prose-first):**
```markdown
## Physics Feature
The physics feature provides simulation capabilities...
It declares dependencies through ports...
```

**Pattern (structure-first):**
```markdown
## Features/Physics/

├── _Ports/              # Physics' Core
├── _Connectors/
└── Dynamics/
```

The folder tree **is** the primary artifact. Prose **annotates** structure.

---

## Prescriptive Rules

### Rule 1: Folder Names Declare Intent

```
_Ports/       → "I declare contracts"
_Connectors/  → "I implement contracts"
_Docs/        → "I explain myself" (note the underscore)
Features/     → "I contain sovereign units"
Hosts/        → "I orchestrate"
```

Use special prefixes (`_`) to signal architectural significance.

### Rule 2: Location Declares Relationships

```
Features/Physics/               → Top-level feature
Features/Physics/FluidDynamics/ → Child feature (contained)
Features/Rendering/             → Sibling feature (independent)
```

Nesting depth communicates hierarchy and ownership.

### Rule 3: Absence Declares Intent

```
Features/Physics/
├── _Ports/       ← Has ports (declares dependencies)
└── (no _Connectors/) ← No connectors (no implementations provided)
```

Missing folders communicate "this unit does not fulfill this role."

### Rule 3: Absence Declares Intent

```
Features/Physics/
├── _Ports/       ← Has ports (declares dependencies)
└── (no _Connectors/) ← No connectors (no implementations provided)
```

Missing folders communicate "this unit does not fulfill this role."

### Rule 4: Symmetry Declares Patterns

```
Features/
├── Physics/
│   ├── _Ports/
│   └── _Connectors/
└── Rendering/
    ├── _Ports/
    └── _Connectors/
```

Parallel structure reveals shared patterns without documentation.

### Rule 5: Trails Preserve Memory

```
Features/Physics/_Chronicles/
├── 2026-01-15-performance-bottleneck.md
├── 2026-01-20-port-design-decision.md
└── 2026-01-25-lazy-formatting-rationale.md
```

Decisions are living artifacts, not lost comments. Future changes reference these trails.

---

## Application Guidelines

### When Creating Features

1. **Start with structure**, not code:
   ```
   mkdir Features/MyFeature/_Ports
   ```

2. **Declare contracts first**:
   ```
   Features/MyFeature/_Ports/IMyContract.cs
   ```

3. **Structure declares sovereignty**:
   ```
   Features/MyFeature/
   ├── _Ports/              # My core identity
   ├── _Connectors/         # My implementations
   └── ChildFeature/        # My sovereign child
       └── _Ports/          # Child's identity
   ```

### When Documenting

1. **Show folder trees first**
2. **Add minimal prose second**
3. **Let structure answer questions**

**Example:**
```markdown
## IPhysicsTraceCollector

Features/Physics/_Ports/IPhysicsTraceCollector.cs

Physics declares its observability contract.
```
*Path tells you: Feature = Physics, Role = Port, Purpose = Trace collection*

### When Reviewing Code

Ask:
1. Does the folder structure declare intent?
2. Can I understand relationships without reading code?
3. Are dependencies discoverable through `_Ports/`?
4. Do folders answer "what, where, why"?

---

## Why This Matters

### For Junior Developers
- **Discover by navigation** instead of reading documentation
- **Understand relationships** through visual tree structure
- **Learn patterns** by observing folder symmetry

### For Senior Developers
- **Enforce architecture** through folder convention
- **Communicate decisions** through structure changes
- **Review intent** before reviewing implementation

### For AI Agents
- **Parse structure** to understand codebase
- **Generate documentation** from folder trees
- **Suggest improvements** based on structural patterns

### For Teams
- **Shared mental model** through consistent structure
- **Implicit onboarding** via discoverable patterns
- **Reduced documentation burden** because structure self-documents

---

## The Litmus Test

**Can a junior developer understand your Feature's dependencies, contracts, and sovereignty by looking at the folder tree alone?**

If yes → structure is communicating  
If no → structure needs improvement

---

## Related Concepts

- [Ports and Connectors](./PortsAndConnectors.md) - The boundary pattern
- [The Fractal Core](./../_Mirages_/TheFractalCore.md) - _Ports as identity
- [Law of Boundaries](./../../__Docs__/_Mirages_/FractalLaws.md) - Sovereignty through contracts

---

**Canon Status:** Foundational Principle  
**Created:** 2026-01-29  
**Ratified:** Emerged from LoggingExperiment implementation and Fractal Core documentation