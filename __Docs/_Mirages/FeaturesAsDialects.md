---
status: non-canon
origin: human+ai
---

# Features as Dialects, Foundations as Alignment Space

> **A Mirage: Team Topology as Architecture Lens**

What if the architecture mirrors the teams?

- **Features** become the *development team’s local workspace* — each team speaks its own dialect.
- **Foundations** become the *architects’ alignment space* — the place where dialects are reconciled when stability is worth the cost.

This isn’t a rule. It’s a lens.

## Why this lens might help

Teams naturally evolve local language, patterns, and tooling. That’s healthy — until shared mechanisms drift so far that the system becomes unreadable or unsafe.

Under this lens:
- Features are allowed to diverge.
- Foundations are where we choose to harmonize.
- Harmonization only happens when multiple teams need the same stable ground.

## What it would prevent

- “Convenient” shared helpers becoming hidden coupling.
- Architecture being enforced from above rather than discovered.
- Teams being forced into one dialect before they’ve learned what they need.

## What it would encourage

- Teams owning their local decisions (Feature sovereignty).
- Architects focusing on alignment only when it serves the whole system.
- A natural promotion path from local experiment → shared foundation.

## The non‑blocking loop (how it avoids “architecture team blocks us”)

1. **Teams ship with local connectors** inside their Features.
2. **Repeated pain emerges** (logging, observability, serialization, threading, tenancy).
3. **Architects harvest proven connectors** into a Foundation adapter with minimal contracts.
4. **Legacy connectors remain** as compatibility artifacts until touched.
5. **Convergence happens gradually** through refactors, not a big‑bang rewrite.

This is the same pattern already visible in the workspace:
- NomadGameEngine Foundations are mostly tech‑level supports (Logging, Serialization, Threading, Memory).
- NomadAI Foundations are adapters that stabilize cross‑cutting tech concerns (Observability, Messaging, Retrieval, Tenancy).

The signal is clear: Foundations are what multiple Features already need, not what an architecture team predicts.

## What becomes “legacy” (and why that’s OK)

When a Foundation is introduced, existing connectors don’t instantly disappear. They become **legacy adapters**:

- They stay as long as no one is refactoring that feature.
- They are replaced when the Feature naturally changes.
- They act as compatibility bridges while the system converges.

This avoids forcing teams into a single dialect before they are ready — and preserves momentum.

## Risks (and the guardrails that keep it honest)

**Risk: Endless divergence**
- Guardrail: require “at least two features” before hardening a Foundation.

**Risk: Foundations turn into a dumping ground**
- Guardrail: tech‑only contracts, no domain semantics.

**Risk: Alignment becomes an architecture bottleneck**
- Guardrail: alignment is optional until convergence offers real leverage.

**Risk: Features never converge**
- Guardrail: when stability matters (ops pain, recurring bugs), promote a shared adapter.

## Alternative lens: Foundations as Translators

Another way to see Foundations is as **translation actors**:

- They speak **technical dialects** (vendor SDKs, infra backends, protocols).
- They also speak **Core / _Contracts language** (the contracts Features rely on).
- Their job is to make the technical world usable **globally** without leaking it into Features.

Under this lens, Foundations are not merely “shared utilities.” They are **interpreters** that allow the system to scale without each Feature learning every technical dialect.

This still preserves sovereignty:
- Features talk to stable ports.
- Foundations translate to specific tech.
- Tech can change without rewriting Features.

## The test

If alignment reduces friction and stabilizes shared needs, it belongs in Foundations.
If alignment only makes teams slower, it should remain a local dialect.

---

*Mirage, not mandate.*
