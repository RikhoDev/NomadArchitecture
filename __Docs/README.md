---
status: canon
kind: doctrine
origin: ai
awaiting_reading: status-header
---

# __Docs

The documentation pillar. It holds the small canon that binds contributors,
and the memory and exploration that inform them without binding them.

## Canon

These files are binding, and nothing else is:

- [Worldview](../Worldview.md): intent, principles and the emergence rhythm.
- [Architecture](Architecture.md): pillars, placement, the Feature README,
  contracts and connectors, promotion.
- [Evidence and Authority](Evidence-And-Authority.md): how strong a claim may
  be, and who decides.
- [This README](README.md): document kinds, status headers, and how canon
  grows.

On 2026-10-21 the human delegated this canon: to infer what they already
hold, and to decide the rest. The inferred rules are canon. The sections the
assistant decided are named in each file's `awaiting_reading`
[header](#status-header), and bind no one until the human has read them.
Evidence for each rule: [README.Trail.20261021.md](README.Trail.20261021.md).
Current state: `pwsh Hosts/DocReader/reader.ps1 canon`.
[AGENTS.md](../AGENTS.md) points contributors and AI assistants here.

## Document kinds

| Kind | Where | Binding | Holds |
|---|---|---|---|
| doctrine | the canon files above | yes | rules in force |
| guide | AGENTS.md, Translation.md, `Concepts/Connectors.md`, folder READMEs | no; it applies doctrine | practical on-ramps |
| mirage | [_Mirages/](_Mirages/README.md) | no | speculation, proposals, AI-generated ideas |
| trail | `<Document>.Trail.<YYYYMMDD>.md`, beside its document | no | how a document came to be |
| chronicle | [_Chronicles/](_Chronicles/README.md) | no | stories and cultural memory |

A Mirage may contain sophisticated or working code; that does not make it
canon. "The danger is not volume. The danger is lying about what a document
is." (NGE:`Engine/__Docs/README.md`, Status Discipline)

## Status header

Every Markdown file except the root `README.md` starts with:

```yaml
---
status: canon | proposed | non-canon | superseded
kind: doctrine | guide | mirage | trail | chronicle
origin: human | ai | ai-assisted
superseded_by: <relative path>   # only when status is superseded
date: YYYY-MM-DD                  # on Chronicles and Mirages; YYYY-MM if the day is unknown
awaiting_reading: <anchor>, ...    # canon sections the human has not yet read
---
```

- `canon`: doctrine the human has authorized.
- `proposed`: a change to doctrine awaiting authorization.
- `non-canon`: guides, Mirages, Trails and Chronicles.
- `superseded`: kept for lineage; `superseded_by` names the replacement.
- `awaiting_reading`: on a canon file, the sections the assistant decided
  under delegation. They are removed one by one as the human reads them.

`origin: ai-assisted` means a human wrote or shaped part of the text, for
example the Shaman's notes; `ai` means the text is the assistant's.

## Trails hold the conversation

When a document is drafted with an AI assistant, the document holds the result
and its Trail holds the conversation, kept verbatim: the prompts, the
assistant's framing and its follow-up offers. The Shaman's notes stay in the
document. A Trail sits beside its document and is dated by the conversation,
or by the first commit when that date is unknown. A change to the canon as a
whole is recorded in the Trail of this README.

## Folder grammar

This is the only place the grammar is defined. It is the convention of
NomadGameEngineV2 (NGE:`Engine/__Docs/README.md`, Naming Conventions),
adopted here at the human's direction on 2026-10-21.

| Prefix | Meaning | Examples |
|---|---|---|
| `__` | documentation, sorted first in explorers | `__Docs/` |
| `_` | structural folders and temporal surfaces | `_Connectors/`, `_Tests/`, `_Mirages/`, `_Chronicles/` |
| none | content, named for the meaning it carries | `Hosts/`, `Canon.ps1`, `Worldview.md` |

Chronicles and Mirages are named `YYMM-xx-Name-Chronicle.md` and
`YYMM-xx-Name-Mirage.md`: the year and month they began, then an index that is
local to their folder and starts at `01` each month. Their `date:` header and
their filename agree, so history sorts by date and survives promotion or
burial. A Host or Feature may carry its own `__Docs/` once its local history
needs room.

## How canon grows

- Canon changes only with explicit human authorization
  ([authority](Evidence-And-Authority.md#authority)).
- Before adding a rule, search canon for an existing one. Amend it or link to
  it instead of restating it. The nomad-method plugin checks this at commit
  time, using the canon list in `.nomad-method/canon`.
- Every addition names what it replaces or removes. If it replaces nothing,
  say why the gap was real.
- A rule promoted from a project's practice cites where that practice lives.
- When evidence overturns a rule, mark it superseded and name its replacement.
- [Scripts/Test-Repository.ps1](../Scripts/README.md) fails if a header, a
  link, the canon list or a proof is wrong. A rule the repository cannot show
  is a rule it does not yet keep.

## Sources

`NGE:` paths refer to the RikhoKorp/NomadGameEngineV2 repository at commit
`37c1907`. Rules that NGE holds but this repository does not yet need wait in
[NGE-Distillation-Candidates](_Mirages/2610-01-NGE-Distillation-Candidates-Mirage.md).

Replaces: the underscore grammar that was defined in both
`_Mirages/README.md` and `_Chronicles/README.md`, and the Mirage header
ritual. Those READMEs now link here.
