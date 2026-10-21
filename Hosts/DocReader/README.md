---
status: non-canon
kind: guide
origin: ai
---

# DocReader

**Promise.** Walk a newcomer through this repository from the terminal: what
binds here, whose meaning a file carries, and where a document came from.

```text
pwsh Hosts/DocReader/reader.ps1                 a tour of this Host
pwsh Hosts/DocReader/reader.ps1 canon           what binds, and what awaits the human
pwsh Hosts/DocReader/reader.ps1 explain <path>  whose meaning a path carries
pwsh Hosts/DocReader/reader.ps1 trail <path>    where a document came from
```

**Residents.** [reader.ps1](reader.ps1) is the Host: it owns the purpose (a
newcomer at a terminal) and the wording on screen. It holds pillars of its own,
because nothing outside it needs them yet:

- [Features/Canon](Features/Canon/README.md): what binds, and what awaits
  reading;
- [Features/Lineage](Features/Lineage/README.md): what a document replaced,
  what replaced it, and its Trails;
- [Features/Placement](Features/Placement/README.md): whose meaning a path
  carries;
- [Foundations/Markdown](Foundations/Markdown/README.md): reading headers,
  links, sections and leads, with no idea what they mean.

**Relationships.** Each Feature states what it needs as a parameter, and the
Host passes the Foundation's functions in. A Feature never loads another
pillar, which is the rule "Foundations implement Feature contracts" in
[Architecture](../../__Docs/Architecture.md#contracts-and-connectors). The
wiring is a few lines at the top of `reader.ps1`, so it needs no
`_Connectors/`.

**Proof.** Each pillar proves its own promise in its `_Tests/`, with fakes where
it has needs. [_Tests/DocReader.Tests.ps1](_Tests/DocReader.Tests.ps1) runs the
real commands against this repository. `Scripts/Test-Repository.ps1` runs all
of them.

**Status.** A Sprout: the smallest honest attempt, grown inside its Host.

- The Markdown Foundation duplicates what `Scripts/Test-Repository.ps1` does to
  read headers and links. That makes two consumers, but both were written by
  the same author, and this one in the same change, so they are weak
  evidence of a shared need. Promoting it to a root `Foundations/Markdown`
  used by both waits for the human to judge that evidence.
- It replaced the Greeting example in October 2026. Greeting's last lesson
  lives here: the Host, not the Feature, decides how a refusal is shown. An
  unknown command exits with code 2, and a path outside the repository exits
  with code 1.

## Absent on purpose

There is no `Core/`. No language is shared yet between this Host and anything
else, and Core is earned through use, not created in advance. There is no
`_Connectors/`, because the only seam is the Host's own composition. Nothing
lives in the root `Features/` or `Foundations/` yet, because no second Host
needs any of this.
