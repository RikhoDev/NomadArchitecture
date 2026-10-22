---
status: canon
kind: doctrine
origin: ai
decided_by_assistant: authority, delegation, when-owners-disagree
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
propose a bounded change. New canon or a material change of direction needs a
human with canon authority: a **canon owner**, one of the people
`.github/CODEOWNERS` names for the canon files.

- Every commit that changes canon says on whose authority, in a
  `Canon-Authority:` trailer:
  - `human`: a canon owner wrote it, or read and confirmed it;
  - `review`: proposed, to merge only with a canon owner's approval;
  - `delegated`: decided by an assistant under a human's delegation, quoted in
    a `Delegation:` trailer.
- A canon change reaches the default branch only through a pull request that a
  canon owner approves. The repository's branch protection must require
  code-owner review for this to hold.
- `Scripts/Test-CanonAuthority.ps1` fails CI when a canon commit declares
  nothing, declares something else, or is delegated without its quote. Git
  reads trailers only from the last paragraph of a commit message, so these
  go in one block with `Co-Authored-By:`.

A working experiment, a passing test, or a reviewer's advice does not gain
that authority by surviving. Ceremony ends in a clear action: promotion,
replacement, or deletion.
(NGE:`AGENTS.md`; NGE:`Engine/__Docs/Patterns/NomadEvolutionRules.md`)

Replaces: "explicit human authorization, recorded with the human's own words,
and with who and when, in the commit that makes the change". That rule named
no one who could authorize, and nothing checked it.

### Delegation

A human may delegate a decision to an assistant. The delegation covers what it
names: "proceed" authorizes the proposal it answers, not what comes after it.
The assistant decides, and records the decision as its own: the sections it
decided are listed in the file's `decided_by_assistant` header. Only a canon
owner's reading clears them, in a commit declared `Canon-Authority: human`;
the check refuses any other.

### When owners disagree

When canon owners disagree, the canon does not change. One owner's request for
changes blocks the merge, and the open question goes into the change's Trail
until the owners settle it. The Shaman of the [Worldview](../Worldview.md#the-shaman)
is not one person above the owners; it is the role they share. Changing who
holds it is a change to `.github/CODEOWNERS`, which canon owners review like
any canon.

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
