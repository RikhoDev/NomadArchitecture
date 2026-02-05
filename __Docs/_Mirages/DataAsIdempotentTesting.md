---
status: experimental
origin: ai
evidence: implemented as dt+input replay bundles and pinned behavior tests in an implementation repo
---

# Data as Idempotent Testing (Mirage)

## Thesis

Some bugs cannot be *invented* reliably via unit tests; they must be *captured*.

If we can record the minimum simulation-affecting inputs and replay them deterministically, then the captured data becomes a durable, CI-enforced non-regression artifact.

## Why this belongs in NomadArchitecture

NomadArchitecture treats **Trails as Evidence**.

Data-backed idempotent tests are a technical form of that evidence:

- A fixture is a trail.
- A replay harness is a contract.
- A pinned baseline is a boundary.

## What “data” means (and does not mean)

This is not “save the whole world every frame”.

It is:

- seed / initial state
- per-step dt
- per-step host inputs

Everything else is auxiliary.

## Risk / Anti-pattern

- Huge fixtures create maintenance debt.
- If determinism is not real, the pattern becomes flaky.
- Fixtures can ossify behavior: use semantic checks alongside hashes.

## Trail to implementation

Concrete example exists in an implementation repo (repro bundles and replay tests).

If this Mirage proves durable, crystallize it into a canonical Concept.
