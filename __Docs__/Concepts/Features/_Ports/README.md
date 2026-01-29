# _Ports  
### The Feature's Mechanical Boundary

---

## Purpose

`_Ports` define **what the Feature needs mechanically**.  
They are pure contracts — nothing more.

---

## What belongs here

- interfaces  
- contracts  
- mechanical boundaries  
- memory dialect definitions  
- policy interfaces  
- tool interfaces  
- capability interfaces  

---

## What does NOT belong here

- logic  
- implementations  
- environment assumptions  
- infrastructure references  
- Host knowledge  
- UI or network code  

---

## Rules

- A Feature depends only on its own `_Ports`.  
- `_Ports` must be stable and environment-agnostic.  
- `_Ports` must not reference Foundations or Hosts.  
- `_Ports` must not contain domain logic.  
- `_Ports` must scream intent.  

---

## Example

```csharp
public interface IMovementIntegrator
{
    void Integrate(ref MovementState state, float deltaTime);
}
```

---

## Checklist

- [ ] Does this file define a contract?  
- [ ] Is it free of logic?  
- [ ] Is it environment-agnostic?  
- [ ] Does it express a mechanical boundary?  
- [ ] Does it belong to this Feature's dialect?  

If all answers are yes, it belongs in `_Ports`.