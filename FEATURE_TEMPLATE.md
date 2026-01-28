# Feature Template

Use this template when creating a new Feature in `Features/`.

- README.md — Why (mission), when to use, owner
- Map.md — How it works, dependencies, wiring
- Traces.md — Execution traces or examples
- _Ports/ — mechanical contracts (interfaces)
- _Connectors/ — default adapters, host bindings, mocks

## Checklist (add when creating a Feature)
- [ ] `README.md` created and explains intent
- [ ] `Map.md` documents wiring and dependencies
- [ ] `Traces.md` contains at least one example trace
- [ ] `_Ports/` contains clear, environment-agnostic contracts
- [ ] `_Connectors/` contains at least one default ritual used by Hosts

## Promotion rules (practical guidance)
- Promote a `_Connector` to `Foundations/` only after multiple Features share the implementation and there is evidence in `Traces.md` that it is stable and reusable.
- Promote a contract into `Core/` only when language and types are repeatable and necessary across Features.

## Minimal README example
```
# {{FeatureName}}

Purpose: ...

Owner: @your-handle

## Usage
Describe how Hosts or other Features use this Feature.
```

## Notes
- Keep Ports contract-only: no implementation or environment assumptions.
- Use `Traces.md` as evidence when generalizing behavior into `Core/` or `Foundations/`.
- Keep documentation and examples small and actionable so they are easy to maintain.

