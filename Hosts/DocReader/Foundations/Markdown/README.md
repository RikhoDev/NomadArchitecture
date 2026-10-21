---
status: non-canon
kind: guide
origin: ai
---

# Markdown

**Promise.** Read this repository's documents mechanically: status headers,
relative links, GitHub anchors, sections and the lead sentence, with no idea of
what any of them mean.

**Residents.** [Markdown.ps1](Markdown.ps1): `Read-StatusHeader`,
`Get-MarkdownLinks`, `ConvertTo-Slug`, `Get-MarkdownSlugs`,
`Get-MarkdownSection`, `Get-MarkdownLead`.

**Relationships.** The [DocReader Host](../../README.md) passes these functions
to its Features. This Foundation uses nothing, and knows no Feature.

**Proof.** [_Tests/Markdown.Tests.ps1](_Tests/Markdown.Tests.ps1) checks each
function on throwaway files, including code fences, inline code and web links,
which must not count as links.

**Status.** Promotion candidate: `Scripts/Test-Repository.ps1` reads headers,
links and anchors with its own copy of this mechanism. That is a second,
independent consumer
([promotion](../../../../__Docs__/Architecture.md#promotion)). Not yet promoted.
