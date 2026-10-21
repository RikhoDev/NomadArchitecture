---
status: non-canon
kind: guide
origin: ai
---

# Lineage

**Promise.** Show where a document came from and what became of it: what it
replaced, what replaced it, and the Trails that hold its conversation.

**Residents.** [Lineage.ps1](Lineage.ps1): `Get-Lineage`.

**Relationships.** It needs a header reader and a list of the repository's
documents; the Host gives it both. It follows the rules for
[`superseded_by`](../../../../__Docs__/README.md#status-header) and for
[Trails](../../../../__Docs__/README.md#trails-hold-the-conversation).

**Proof.** [_Tests/Lineage.Tests.ps1](_Tests/Lineage.Tests.ps1), with fake
documents, including a `superseded_by` loop that must not hang.

**Status.** Its proof passes. A Trail is found by name, beside its document, as the
convention says.
