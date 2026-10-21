---
status: non-canon
kind: guide
origin: ai
---

# Placement

**Promise.** For any path in this repository, answer "whose meaning is this?":
the pillars it sits inside, the world it belongs to, and the nearest README
that owns it.

**Residents.** [Placement.ps1](Placement.ps1): `Get-Placement`.

**Relationships.** It needs a way to read a README's lead sentence; the Host
gives it the Markdown Foundation's. It applies the placement test in
[Architecture](../../../../__Docs__/Architecture.md#placement) as far as a
folder tree can show it. Whether the path is in the right home stays a human
judgement.

**Proof.** [_Tests/Placement.Tests.ps1](_Tests/Placement.Tests.ps1), on a
throwaway tree.

**Status.** Its proof passes. It reads ownership from READMEs; a folder without one is
owned by the nearest folder above that has one.
