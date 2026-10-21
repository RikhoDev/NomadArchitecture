---
status: proposed
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
  -> proof
  -> retained, promoted, quarantined, superseded, or removed
```

Contributors and AI assistants may map evidence, challenge an assumption, and
propose a bounded change. New canon or a material change of direction needs
explicit human authorization. Record who authorized it and when, in the commit
message or the document, as NGE does for its committed-image rule. A working
experiment, a passing test, or a review handoff does not gain that authority
by surviving.

Ceremony ends in a clear action: promotion, replacement, or deletion. It does
not mean keeping every predecessor forever.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`;
NGE:`Engine/__Docs/Patterns/Architecture-Documentation-Legibility-Protocol.md`)

## Claims

Label what a claim is:

- **OBS**, observed: seen in a file, a run, or a record. Cite it.
- **INT**, interpreted: a reading of observations.
- **UNK**, unknown: not established. Unknown stays unknown; do not round it
  up.
- **PROP**, proposed: a change being suggested, not yet decided.

A claim that cannot name its subject, owner, evidence and open questions is
probably still folklore. (NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §8)

Replaces nothing. The 2025 Worldview said "humans at the center" and "evidence
precedes generalization" but gave no way to tell a decision from a proposal,
or an observation from a reading of it. The 2025 Worldview itself was
"AI re-generated, unrevised" and committed in the voice of canon, which shows
the gap was real.
