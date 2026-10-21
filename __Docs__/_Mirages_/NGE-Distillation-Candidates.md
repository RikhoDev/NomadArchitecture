---
status: non-canon
kind: mirage
origin: ai-assisted
---

# NGE distillation candidates

Rules that NomadGameEngineV2 (NGE) holds and that may generalise, but that
this repository has no need for yet. They were drafted into canon on
2026-10-21, and the isolated review moved them out: a docs-only repository has
no multi-provider realization, no proof world and no recursion inside a
Feature to test them against. Promote one only when a project shows the need
(see [Architecture: promotion](../Architecture.md#promotion)).

Citations use the `NGE:` form defined in [Sources](../README.md#sources).

## Three worlds

A repository holds three worlds that relate but are not interchangeable:

- the **repository world** scaffolds the system: build, scripts, CI, tools;
- the **system world** is the system itself, organised in pillars;
- the **proof world** validates the system without becoming part of what it
  means.

Of any root artifact, ask: does it define the system, or scaffold it? If it
scaffolds, it stays outside the pillars.
(NGE:`Engine/__Docs/ROOT-ONTOLOGY.md`;
NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §1)

## The split recurs inside a Feature

```text
root           = the public WHAT and directly cohesive local HOW
_Capabilities  = an earned, subordinate local HOW
_Connectors    = the Feature's relationships
named child    = another sovereign WHAT
```

Each level must earn an independent promise, invariant, consumer boundary or
proof surface; this is not permission for symmetrical folder boilerplate. NGE
itself holds this recursion as active under validation, and its
`_Capabilities` folders exist only in three backend folders.
(NGE:`Engine/__Docs/Patterns/Feature-Sovereignty-Doctrine.md`)

## Realization

When more than one provider can realize a promise:

1. the Feature states what its meaning requires, not which provider or API to
   use;
2. providers advertise neutral capabilities;
3. composition resolves support, a named degradation, or a refusal;
4. the Host decides whether that outcome is acceptable.

A required capability protects the promise; an optional one describes a better
or cheaper way to keep it. A missing requirement is a gap until a named
alternative and Host acceptance exist. Never silently weaken the promise.
(NGE:`AGENTS.md`;
NGE:`Engine/__Docs/Dossiers/2609-11-Feature-First-Filesystem-Sovereignty-Target-Architecture.md`)

## Evidence levels

| Level | Means |
|---|---|
| structural | shape, placement or existence is shown |
| focused proof | owning tests or narrow checks prove the local claim |
| operational | representative use proves the claim in practice |
| closure | the declared exit signal is earned and nothing is left open |
| contradicted | current evidence disproves the claim; repair or demote it |

The levels do not imply one another. Reserve "complete" and "done" for
closure. (NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §6, §9)

## Doctrine maturity

Doctrine can be speculative (a Mirage), **active under validation**, or
settled. Doctrine under validation governs new work because it has enough
evidence to act on, while naming what could still contradict it. A
contradiction repairs the doctrine; it does not erase the evidence that
justified acting. (NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §11)
