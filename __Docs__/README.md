---
status: canon
kind: doctrine
origin: ai-assisted
---

# __Docs__

The documentation pillar. It holds the small canon that binds contributors,
and the memory and exploration that inform them without binding them.

## Canon

These files are binding. Nothing else is canon, whatever its tone.

- [Worldview](../Worldview.md): intent and commitments.
- [Architecture](Architecture.md): pillars, placement, contracts and
  connectors, promotion.
- [Evidence and Authority](Evidence-And-Authority.md): how strong a claim may
  be, and who decides.
- This README: document kinds, status headers, and how canon grows.

[AGENTS.md](../AGENTS.md) points contributors and AI assistants to these files.
It adds no rules of its own.

## Document kinds

| Kind | Where | Binding | Holds |
|---|---|---|---|
| doctrine | the canon files above | yes | rules in force |
| guide | [Translation.md](Translation.md), [FEATURE_TEMPLATE.md](../FEATURE_TEMPLATE.md), folder READMEs | applies canon, adds no rules | practical on-ramps |
| mirage | [_Mirages_/](_Mirages_/README.md) | no | speculation, proposals, AI-generated ideas |
| trail | `<Document>.Trail.<YYYYMMDD>.md`, beside its document | no | how a document came to be |
| chronicle | [_Chronicles_/](_Chronicles_/README.md) | no | stories and cultural memory |

A Mirage may contain sophisticated or working code; that does not make it
canon. A superseded document stays where it is for lineage and says so in its
header. As NomadGameEngineV2 puts it: "The danger is not volume. The danger is
lying about what a document is." (NGE:`Engine/__Docs/README.md`, Status
Discipline)

## Status header

Every Markdown file except the root `README.md` starts with:

```yaml
---
status: canon | non-canon | superseded
kind: doctrine | guide | mirage | trail | chronicle
origin: human | ai | ai-assisted
superseded_by: <relative path>   # only when status is superseded
---
```

This extends the ritual first written in [_Mirages_/README.md](_Mirages_/README.md).

## Trails hold the conversation

When a document is drafted with an AI assistant, the document holds the result
and its Trail holds the conversation: the prompts, the assistant's framing, and
its follow-up offers, kept verbatim. The human's own notes (Shaman's notes)
stay in the document. A Trail sits beside its document and is dated by the
conversation, or by the first commit when that date is unknown.

## Folder grammar

This is the only place the grammar is defined; other READMEs link here.

- `__Docs__`: the documentation pillar. It is the only folder with double
  underscores; the other pillars use plain names (`Core`, `Features`,
  `Foundations`, `Hosts`).
- `_Name_`: a non-canon tent inside `__Docs__`, such as `_Mirages_` and
  `_Chronicles_`.
- `_Name`: a support inside a Feature, such as `_Connectors`.
- `Name`: a resident named for the meaning it carries.

## How canon grows

- Canon changes only with explicit human authorization; see
  [Evidence and Authority](Evidence-And-Authority.md#authority).
- Before adding a rule, search canon for an existing one. Amend it or link to
  it instead of restating it.
- Every addition names what it replaces or removes, in the document and in the
  commit message. If it replaces nothing, say why the gap was real.
- One fact has one owner. Other documents summarise and link to it.
  (NGE:`Engine/__Docs/Patterns/Architecture-Documentation-Legibility-Protocol.md`)
- A rule promoted from a project's practice cites where that practice lives, so
  its evidence can be checked.
- When evidence overturns a rule, mark it superseded and name its replacement.
  Delete it only once its lineage is no longer useful.

## Sources

`NGE:` paths refer to
[RikhoKorp/NomadGameEngineV2](https://github.com/RikhoKorp/NomadGameEngineV2)
at commit `37c1907`. The October 2026 canon was distilled from that practice;
the reasoning is recorded in
[Worldview.Trail.20261021.md](../Worldview.Trail.20261021.md).

## Open decisions

Recorded here until a human decides them:

- Per-Feature `Map.md` and `Traces.md` (this repository) versus the
  six-question folder README used in NGE
  (NGE:`Engine/__Docs/Patterns/Architecture-Documentation-Legibility-Protocol.md`).
- [Caravans/](../Caravans/README.md): no consumer of the manifest was found.
  Keep it, or remove it.
- Folder grammar: NGE uses prefixes only (`__Docs`, `_Mirages`); this
  repository keeps the wrapped form.
- Whether to add a runnable example outside game engines.
