# The Fractal Core

> **TL;DR:** A Feature's Core = its `_Ports/` folder. This pattern repeats at every level.

---

## What is Core/ vs _Ports/?

```
NomadArchitecture/
│
├── Core/                    # ← Shared infrastructure (types, utilities)
│   ├── Entity.cs
│   ├── Component.cs
│   └── ...
│
└── Features/
    └── Physics/
        ├── _Ports/          # ← Physics' Core (its contract)
        │   └── IPhysicsTraceCollector.cs
        ├── _Connectors/
        └── Dynamics/
            └── PhysicsWorld.cs
```

- **Core/** = infrastructure used by everyone
- **_Ports/** = this Feature's identity (what it needs, what it offers)

---

## The Pattern: _Ports at Every Level

### Level 1: Top-Level Feature

```
Features/
└── Physics/
    ├── _Ports/              # ← Physics declares: "I need trace collection"
    │   └── IPhysicsTraceCollector.cs
    ├── Dynamics/
    │   └── PhysicsWorld.cs  # ← Uses IPhysicsTraceCollector
    └── _Connectors/
```

**Physics' Core** = `IPhysicsTraceCollector` interface in `_Ports/`

### Level 2: Child Feature

```
Features/
└── Physics/
    ├── _Ports/
    │   └── IPhysicsTraceCollector.cs
    └── FluidDynamics/       # ← Child feature
        ├── _Ports/          # ← FluidDynamics declares: "I need fluid observers"
        │   └── IFluidObserver.cs
        ├── Solvers/
        └── _Connectors/
```

**FluidDynamics' Core** = `IFluidObserver` interface in its `_Ports/`

### Level 3: Grandchild Feature

```
Features/
└── Physics/
    ├── _Ports/
    │   └── IPhysicsTraceCollector.cs
    └── FluidDynamics/
        ├── _Ports/
        │   └── IFluidObserver.cs
        └── ParticleSim/     # ← Grandchild feature
            ├── _Ports/      # ← ParticleSim declares its own contract
            │   └── IParticleEmitter.cs
            ├── Emitters/
            └── _Connectors/
```

**ParticleSim's Core** = `IParticleEmitter` interface in its `_Ports/`

---

## The Fractal Rule

```
At any level of nesting:
  _Ports/ = that unit's Core
```

### Entire System View

```
Features/
│
├── Physics/
│   ├── _Ports/              # Physics' Core
│   ├── FluidDynamics/
│   │   ├── _Ports/          # FluidDynamics' Core
│   │   └── ParticleSim/
│   │       └── _Ports/      # ParticleSim's Core
│   └── Collision/
│       └── _Ports/          # Collision's Core
│
├── Rendering/
│   ├── _Ports/              # Rendering's Core
│   └── Pipelines/
│       └── Deferred/
│           └── _Ports/      # Deferred's Core
│
└── AI/
    ├── _Ports/              # AI's Core
    └── Pathfinding/
        └── NavMesh/
            └── _Ports/      # NavMesh's Core
```

**Every `_Ports/` folder is that unit's Core—its contract with the world.**

---

## Real Example: Physics Tracing

### The Problem

```
Features/Physics/
└── Dynamics/
    └── PhysicsWorld.cs
        └── Step() → RuntimeTrace.Log(...)  # ← Hard-coded dependency
```

- Physics directly calls static `RuntimeTrace`
- Can't swap implementations
- Can't turn off in production
- 36,000 string allocations per second

### The Solution

#### Step 1: Physics Declares Its Core

```
Features/Physics/
├── _Ports/                              # ← Physics' Core
│   └── IPhysicsTraceCollector.cs        # ← The contract
└── Dynamics/
    └── PhysicsWorld.cs
```

```csharp
// Features/Physics/_Ports/IPhysicsTraceCollector.cs
public interface IPhysicsTraceCollector
{
    void RecordVelocity(Entity actor, Vector3 before, Vector3 after, string reason);
    void RecordGrounding(Entity actor, bool isGrounded);
}
```

#### Step 2: Physics Uses Its Port

```csharp
// Features/Physics/Dynamics/PhysicsWorld.cs
public class PhysicsWorld
{
    public IPhysicsTraceCollector TraceCollector { get; set; } = new NullPhysicsTracer();
    
    public void Step(float deltaTime)
    {
        foreach (var body in _bodies)
        {
            TraceCollector.RecordVelocity(body.Entity, oldVel, newVel, "Gravity");
        }
    }
}
```

#### Step 3: Host Provides Implementation

```
Hosts/LoggingExperiment/
├── Program.cs
├── LoggingExperimentRuntime.cs          # ← Wires the port
└── _Connectors/
    ├── LazyFormattingPhysicsTracer.cs   # ← Implementation 1
    └── NullPhysicsTracer.cs             # ← Implementation 2
```

```csharp
// Hosts/LoggingExperiment/LoggingExperimentRuntime.cs
var tracer = enableTracing 
    ? new LazyFormattingPhysicsTracer()  // Development: detailed logs
    : new NullPhysicsTracer();           // Production: zero cost

physicsWorld.TraceCollector = tracer;
```

### The Wiring

```
┌─────────────────────────────────────────────────────────────┐
│ Host: LoggingExperiment                                     │
│   ├── Reads Physics' Core: IPhysicsTraceCollector          │
│   ├── Chooses: LazyFormattingPhysicsTracer                 │
│   └── Injects: physicsWorld.TraceCollector = tracer        │
└─────────────────────────────────────────────────────────────┘
                             ↓
┌─────────────────────────────────────────────────────────────┐
│ Feature: Physics                                            │
│   ├── _Ports/IPhysicsTraceCollector.cs ← its Core          │
│   └── Uses: TraceCollector.RecordVelocity(...)             │
└─────────────────────────────────────────────────────────────┘
```

**Result:** 36,000 allocations/sec → 0 allocations/sec in production

---

## Quick Reference

| Level | _Ports/ Location | What It Declares |
|-------|------------------|------------------|
| **Top-Level Feature** | `Features/MyFeature/_Ports/` | MyFeature's contract |
| **Child Feature** | `Features/MyFeature/ChildFeature/_Ports/` | ChildFeature's contract |
| **Grandchild Feature** | `Features/MyFeature/ChildFeature/GrandchildFeature/_Ports/` | GrandchildFeature's contract |

### The Questions _Ports/ Answers

1. What does this unit **need** from the world?
2. What does this unit **offer** to the world?
3. What **language** must others speak to interact with it?

### The Rule

```
When you see _Ports/, you're looking at that unit's Core—its identity.
```

---

## See Also

- [LoggingExperiment Host](../../Hosts/LoggingExperiment/README.md) - Full implementation
- [Ports and Connectors](../Concepts/PortsAndConnectors.md) - Pattern details
