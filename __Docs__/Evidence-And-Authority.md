---
status: canon
kind: doctrine
origin: ai
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
explicit human authorization, recorded with the human's own words, and with
who and when, in the commit that makes the change. A working experiment, a
passing test, or a reviewer's advice does not gain that authority by
surviving.

Ceremony ends in a clear action: promotion, replacement, or deletion.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`)

## Claims

Keep three kinds of statement apart, and say which one you are making:

- **observed:** seen in a file, a run, or a record, and cited;
- **interpreted:** a reading of what was observed;
- **unknown:** not established. Unknown stays unknown; do not round it up. A
  search that finds nothing proves only that this search found nothing.

A conclusion reached under someone's hints is steered, and says so.
(NGE:`Engine/__Docs/Ontology/ENGINE-ONTOLOGY-CANON.md` §8; the nomad-method
plugin's working discipline)

Replaces nothing. The 2025 Worldview said "humans at the center" and "evidence
precedes generalization", but gave no way to tell a decision from a proposal,
or an observation from a reading of it. That gap was real: the 2025 Worldview
itself was marked "AI re-generated, unrevised" and committed in the voice of
canon.
