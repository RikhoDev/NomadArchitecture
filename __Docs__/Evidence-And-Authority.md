---
status: canon
kind: doctrine
origin: ai-assisted
---

# Evidence and Authority

How strong a claim may be, and who may turn a claim into a decision.

## Authority

Observation, interpretation, decision, implementation and proof are different
kinds of claim:

```text
observation
  -> interpretation
  -> architecture decision
  -> authorized implementation
  -> focused proof
  -> retained, promoted, quarantined, superseded, or removed
```

Contributors and AI assistants may map evidence, challenge an assumption, and
propose a bounded change. New canon or a material change of direction needs
explicit human authorization; record who authorized it and when, in the commit
message or the document. A working experiment, a passing test, or a review
handoff does not gain that authority by surviving.

Ceremony ends in a clear action: promotion, replacement, or deletion. It does
not mean keeping every predecessor forever.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`)

## Claims

Label what a claim is:

- **OBS**, observed: seen in a file, a run, or a record. Cite it.
- **INT**, interpreted: a reading of observations.
- **UNK**, unknown: not established. Unknown stays unknown; do not round it
  up.
- **PROP**, proposed: a change being suggested, not yet decided.

A claim that cannot name its subject, owner, evidence and open questions is
probably still folklore. (NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §8)

## Evidence levels

| Level | Means |
|---|---|
| structural | shape, placement or existence is shown |
| focused proof | owning tests or narrow checks prove the local claim |
| operational | representative use proves the claim in practice |
| closure | the declared exit signal is earned and nothing is left open |
| contradicted | current evidence disproves the claim; repair or demote it |

The levels do not imply one another: structural is not focused proof, focused
proof is not operational, operational is not closure. Reserve "complete" and
"done" for closure. A screenshot or a passing unit test alone does not
establish runtime, visual or cross-environment acceptance.
(NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §6, §9)

## Doctrine maturity

Doctrine can be speculative (a Mirage), **active under validation**, or
settled. Doctrine under validation governs new work because it has enough
evidence to act on, while naming what could still contradict it. A
contradiction repairs the doctrine; it does not erase the evidence that
justified acting. (NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §11)
