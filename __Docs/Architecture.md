---
status: canon
kind: doctrine
origin: ai
awaiting_reading: feature-readme
---

# Architecture

How a NomadArchitecture system is shaped. Each rule cites the NGE practice it
was distilled from ([Sources](README.md#sources)). The
[DocReader Host](../Hosts/DocReader/README.md) is built by these rules, and the
repository check runs its proofs.

## Pillars

- A **Host** (WHY) composes Features into something runnable and decides what
  it accepts from them, including how a refused promise is shown. Hosts are
  replaceable roofs, never the soul.
- A **Feature** (WHAT) owns a promise and the meaning behind it.
- A **Foundation** (HOW) owns neutral mechanism. It implements contracts;
  reusing an implementation does not make it their owner.
- **Core** (COMMON) owns shared language and its invariants. Code does not
  belong in Core because it is shared; it belongs there when the system
  becomes less honest without it.
- **__Docs** owns memory ([README.md](README.md)).

A pillar is earned, not scaffolded: an empty `Core/` or `Foundations/` folder
claims something nobody has needed.
(NGE:`Engine/__Docs/Patterns/Feature-Sovereignty-Doctrine.md`;
NGE:`Engine/Hosts/README.md`; NGE:`Engine/Core/README.md`)

Replaces: "Core: the rules and contracts (the DNA)" and "Hosts: delivery
skins" in the old root README.

## Placement

The governing test: **whose meaning disappears if this artifact disappears?**
That owner is the artifact's home, whatever its language or file extension. If
the test cannot give an answer without inventing a technology exception,
record the contradiction as evidence and correct the doctrine.

Before adding or moving an artifact, apply three tests:

- **Explorer:** opened cold, do the first-level names explain the world and
  its responsibilities, or only its technologies?
- **Caravan:** from inside an owner, can you reach its logic, its diagnostics,
  its proof and its lineage without needlessly leaving the neighbourhood?
  Exact colocation is not required; navigation led by meaning is.
- **Sovereignty:** if the owner vanished tomorrow, would this artifact vanish
  with it? If it would remain as shared machinery, it belongs to Foundations or
  to the composition that uses it.

Folder count, uniform depth and cosmetic symmetry are not evidence of
improvement. Change placement where a concrete boundary is being clarified;
never bulk-relocate to make a diagram look uniform.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/Feature-Caravan-Sovereignty.md`)

Replaces nothing. "No dumping grounds" stated the aim without a test to apply.

## Feature README

Each Feature root carries one `README.md` that answers:

- **Promise:** what it owns or makes possible;
- **Residents:** which files fulfil the promise;
- **Relationships:** what it uses, what uses it, and what it deliberately does
  not own;
- **Proof:** which check makes its behaviour inspectable;
- **Status:** what is settled and what is still open.

One fact has one owner: a parent summarises and links, and does not copy.
(Adapted from NGE:`Engine/__Docs/Patterns/Architecture-Documentation-Legibility-Protocol.md`,
which adds a sixth question, control surface, for engine parameters.)

Replaces: per-Feature `Map.md` (how) and `Traces.md` (proof). NGE uses neither
file after nine months of practice; the same questions now live in one place.

## Contracts and connectors

> The edge of a Feature is defined by what it needs and what it promises, not
> by what it exposes mechanically. Contracts name that edge. Connectors fulfill
> it at real seams.

- A contract belongs to the owner of its meaning: a public promise at the
  Feature root, relationship vocabulary beside its connector, neutral
  mechanism in Foundations, shared language in Core. A generic contracts folder
  is not an owner.
- Foundations implement Feature contracts; they normally do not invent them.
  Dependencies point toward the contracts being implemented.
- A connector is thin. It wires a real seam: composition, dependency
  injection, runtime adaptation, synchronisation between domains, tool
  integration. If it grows an algorithm, move it to its owner. If it invents
  meaning, the owning pillar is being bypassed.
- Connectors are not promoted; the mechanisms and contracts they reveal are.
- No speculative defaults: the absence of wiring is the noop. A Host that does
  not need a Feature does not wire it, and nothing falls back on its behalf.

(NGE:`Engine/__Docs/Patterns/Contracts-And-Connectors-Doctrine.md`;
NGE:`Engine/__Docs/Worldview.md` §3, §7)

Replaces: `_Ports`, the three-tier fallback, "Hosts override `_Connectors`",
"`_Connectors` must not reference other Features", and connector promotion to
Foundations ([superseded](Concepts/PortsAndConnectors.md)).

## Promotion

Systems grow from pressure, not prediction
([emergence rhythm](../Worldview.md#emergence-rhythm)). Ownership moves up
one earned step at a time:

```text
local capability or collocated contract
  -> Feature root, when an owner earns a public promise
  -> child Feature, when local HOW earns an independent WHAT
  -> Foundations, when the mechanism is neutral across owners
  -> Core, only when common language emerges across pillars
```

**Two independent consumers are enough** when their problem is real and their
differences are understood; never invent a third. A difference between them is
evidence about where the line falls, not a veto: only a fundamental conflict
between their truths argues against the abstraction. Promotion changes
ownership; it is not an award for reuse, maturity or consumer count. Do not
promote because an AI suggested an abstraction before the seam was proven.

When a promotion is earned, update the rule it changes, keep dependency
direction honest, move the proof with its owner, and leave a Trail.
(NGE:`Engine/__Docs/ADRs/0011-variance-aware-useful-generalization.md`,
accepted 2026-09-30; NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`)

Replaces: "`_Ports` → Core", and two promotion thresholds that disagreed:
"at least 3 Features" (`Translation.md`) and "multiple Features" (the
former `FEATURE_TEMPLATE.md`).
