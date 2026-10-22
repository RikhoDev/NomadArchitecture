---
status: non-canon
kind: guide
origin: ai
---

# Canon

**Promise.** Say what binds in this repository, and which parts of it the
assistant decided under the human's delegation.

**Residents.** [Canon.ps1](Canon.ps1): `Get-Canon`, which reads the canon list
in `.nomad-method/canon` and each file's status and `decided_by_assistant`
header.

**Relationships.** It needs a header reader: a function from a path to its
status header. The Host gives it the Markdown Foundation's. It does not decide
what canon is; [__Docs/README.md](../../../../__Docs/README.md#canon)
does.

**Proof.** [_Tests/Canon.Tests.ps1](_Tests/Canon.Tests.ps1), with a fake header
reader.

**Status.** Its proof passes. It does not check that the canon lists
agree; `Scripts/Test-Repository.ps1` does.
