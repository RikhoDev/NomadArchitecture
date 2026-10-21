---
status: non-canon
kind: guide
origin: ai-assisted
---

# Feature Template

The living template is the [Greeting Feature](examples/Greeting/Features/Greeting/README.md):
copy its shape, not its words. This page is the checklist that applies
[Architecture](__Docs__/Architecture.md) when you create a Feature in
`Features/`.

## Checklist

- [ ] The Feature is named for the meaning it carries, not its technology.
- [ ] The public promise sits at the Feature root.
- [ ] `README.md` answers the [Feature README](__Docs__/Architecture.md#feature-readme)
      questions: promise, residents, relationships, proof, status.
- [ ] A proof in `_Tests/` checks each claim the README makes, and passes in
      `Scripts/Test-Repository.ps1`.
- [ ] `_Connectors/` exists only if a real seam needs wiring today.
- [ ] Nothing was moved to Core or Foundations ahead of a second consumer
      ([promotion](__Docs__/Architecture.md#promotion)).

## Minimal README

```markdown
---
status: non-canon
kind: guide
origin: human
---

# {{FeatureName}}

**Promise.** ...
**Residents.** ...
**Relationships.** ...
**Proof.** ...
**Status.** ...
```

## Lineage

Earlier versions asked for `Map.md`, `Traces.md` and `_Ports/` in every
Feature. They are superseded by the Feature README and the contract rules; see
[README.Trail.20261021.md](__Docs__/README.Trail.20261021.md).
