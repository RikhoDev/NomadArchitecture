# _Connectors  
### The Feature's Integration Surface

---

## Purpose

`_Connectors` contain everything that allows the Feature to **plug into the world**.

They are the Feature's:

- default implementations  
- adapters  
- bridges  
- route maps  
- UI bindings  
- protocol bindings  
- environment-specific glue  
- test doubles  
- identity manifests  

---

## What belongs here

- default implementations of `_Ports`  
- adapters to Foundations  
- adapters to Hosts  
- HTTP route maps  
- CLI bindings  
- Angular services  
- Web components  
- Node/Express adapters  
- gRPC bindings  
- Kafka bindings  
- mocks and test doubles  
- identity manifests  

---

## What does NOT belong here

- domain logic  
- cross-Feature knowledge  
- Host orchestration  
- environment secrets  

---

## Rules

- `_Connectors` must not contain domain logic.  
- `_Connectors` must be override-friendly.  
- `_Connectors` must not reference other Features.  
- `_Connectors` must not assume a specific environment.  
- `_Connectors` must expose the Feature's capabilities cleanly.  

---

## Example

```csharp
public class LocalMovementIntegrator : IMovementIntegrator
{
    public void Integrate(ref MovementState state, float deltaTime)
    {
        // default mechanical implementation
    }
}
```

---

## Checklist

- [ ] Does this file integrate the Feature with the world?  
- [ ] Is it free of domain logic?  
- [ ] Is it override-friendly?  
- [ ] Does it expose capabilities cleanly?  
- [ ] Does it belong to this Feature's integration surface?  

If all answers are yes, it belongs in `_Connectors`.
