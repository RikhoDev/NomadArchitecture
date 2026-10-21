---
status: canon
kind: guide
origin: ai-assisted
---

# Feature Template

Use this template when creating a new Feature in `Features/`.

- README.md — Why (mission), when to use, owner
- Map.md — How it works, dependencies, wiring
- Traces.md — Execution traces or examples
- Contracts — the Feature's public promise, at the Feature root
- _Connectors/ — only when the Feature has a real relationship to wire; see [_Connectors](Features/_Connectors/README.md)

## Checklist (add when creating a Feature)
- [ ] `README.md` created and explains intent
- [ ] `Map.md` documents wiring and dependencies
- [ ] `Traces.md` contains at least one example trace
- [ ] Public contracts sit at the Feature root and name what the Feature needs and promises
- [ ] Every file in `_Connectors/` wires a seam that exists today; no speculative defaults

## Promotion rules (practical guidance)
- Promotion follows [Architecture: promotion](__Docs__/Architecture.md#promotion). Use `Traces.md` as part of the evidence.

## Minimal README example
```
# {{FeatureName}}

Purpose: ...

Owner: @your-handle

## Usage
Describe how Hosts or other Features use this Feature.
```

## Notes
- Keep contracts free of implementation and environment assumptions.
- Keep documentation and examples small and actionable so they are easy to maintain.

