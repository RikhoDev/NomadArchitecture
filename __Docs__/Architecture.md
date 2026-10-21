---
status: proposed
kind: doctrine
origin: ai-assisted
---

# Architecture

How a NomadArchitecture system is shaped. Each rule cites the NGE practice it
was distilled from (see [Sources](README.md#sources)).

## Pillars

```text
Host        = WHY    composition intent
Feature     = WHAT   sovereign promise
Foundation  = HOW    neutral mechanism
Core        = COMMON emergent language
__Docs__    = memory
```

- A **Host** composes Features into something runnable and decides what it
  accepts from them. Hosts are replaceable roofs, never the soul.
- A **Feature** owns a promise and the meaning behind it.
- A **Foundation** owns neutral mechanism. It implements contracts; reusing an
  implementation does not make it their owner.
- **Core** owns shared language and its invariants. Code does not belong in
  Core because it is shared; it belongs there when the system becomes less
  honest without it.
- **__Docs__** owns memory; see [README.md](README.md).

(NGE:`Engine/__Docs/Patterns/Feature-Sovereignty-Doctrine.md`;
NGE:`Engine/Hosts/README.md`; NGE:`Engine/Core/README.md`)

Replaces: the canonical skeleton table in the 2025 Worldview.

## Placement

The governing test: **whose meaning disappears if this artifact disappears?**
That owner is the artifact's home, whatever its language or file extension. If
the test cannot give an answer without inventing a technology exception,
record the contradiction as evidence and correct the doctrine.

Before adding or moving an artifact, apply three tests:

- **Explorer:** opened cold, do the first-level names explain the world and
  its responsibilities, or only its technologies?
- **Caravan:** from inside an owner, can you reach its logic, its expressions in
  other languages, its diagnostics, its proof and its lineage without needlessly
  leaving the neighbourhood? Exact colocation is not required; navigation led by
  meaning is.
- **Sovereignty:** if the owner vanished tomorrow, would this artifact vanish
  with it? If it would remain as shared machinery, it belongs to Foundations or
  to the composition that uses it.

Folder count, uniform depth and cosmetic symmetry are not evidence of
improvement. Change placement incrementally, where a concrete boundary is being
clarified; never bulk-relocate to make a diagram look uniform.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/Feature-Caravan-Sovereignty.md`)

Replaces: "No dumping grounds" and "Placement is narrative" in the 2025
Worldview, which stated the aim without a test.

## Contracts and connectors

> The edge of a Feature is defined by what it needs and what it promises, not
> by what it exposes mechanically. Contracts name that edge. Connectors fulfill
> it at real seams.

- A contract belongs to the owner of its meaning: a public promise at the
  Feature root, relationship vocabulary beside its connector, private
  vocabulary beside its implementation, neutral mechanism in Foundations,
  shared language in Core. A generic contracts folder is not an owner.
- Foundations implement Feature contracts; they normally do not invent them.
  Dependencies point toward the contracts being implemented.
- A connector is thin. It wires a real seam: composition, dependency
  injection, runtime adaptation, synchronisation between domains, tool
  integration. If it grows an algorithm, extract it to its owner. If it
  invents meaning, the owning pillar is being bypassed.
- Connectors are not promoted; the mechanisms and contracts they reveal are.
- No speculative defaults: the absence of wiring is the noop. A Host that does
  not need a Feature does not wire it, and nothing falls back on its behalf.

(NGE:`Engine/__Docs/Patterns/Contracts-And-Connectors-Doctrine.md`;
NGE:`Engine/__Docs/Worldview.md` §3, §7)

Replaces: `_Ports` as a mandatory Feature folder, the three-tier fallback,
"Hosts override `_Connectors`", "`_Connectors` must not reference other
Features", and connector promotion to Foundations, all now
[superseded](Concepts/PortsAndConnectors.md).

## Promotion

Systems grow from pressure, not prediction:

1. **A Host sparks.** Intent and code begin together in one runnable place.
2. **The Host exposes a seam.** Real pressure shows something missing.
3. **Foundations harden.** Reusable mechanism leaves the Host.
4. **Features earn their meaning.** Shared meaning becomes a Feature only
   after real use proves the need.
5. **Core remembers.** Language becomes Core only when it is common across
   pillars.

(NGE:`README.md`, Promotion Flow)

Ownership moves up this ladder one earned step at a time:

```text
local capability or collocated contract
  -> Feature root, when an owner earns a public promise
  -> child Feature, when local HOW earns an independent WHAT
  -> Foundations, when the mechanism is neutral across owners
  -> Core, only when common language emerges across pillars
```

Differences between candidates are evidence for classification, not a veto.
Classify each one as domain meaning, policy variance, realization variance,
fundamental conflict, or unknown. Only a fundamental conflict argues against
the abstraction; unknown means investigate. **Two independent consumers are
enough** when their problem is real and their variance is understood; never
invent a third.

A candidate states its promise, its exclusions, the variance it leaves local,
the duplicate work it removes, and the work a future consumer no longer has to
invent. Promotion changes ownership; it is not an award for reuse, maturity,
performance or consumer count. Proving that another implementation fulfils an
existing promise is realization acceptance, not promotion.

Do not promote because an implementation is reused, a type feels important, a
central folder looks tidier, or an AI suggested an abstraction before the seam
was proven. When a promotion is earned, update the rule it changes, keep
dependency direction honest, move proof with its owner, and leave a Trail.
(NGE:`Engine/__Docs/ADRs/0011-variance-aware-useful-generalization.md`;
NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`)

Replaces: the 2025 emergence rhythm (Host, Features, `_Connectors`, `_Ports`,
Foundations, Core), which put Features before Foundations; the promotion
thresholds "at least 3 Features" in [Translation.md](Translation.md) and
"multiple Features" in [FEATURE_TEMPLATE.md](../FEATURE_TEMPLATE.md); and
"`_Ports` → Core".
