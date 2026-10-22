---
status: non-canon
kind: guide
origin: ai
---

# Scripts

Tools that keep the repository honest. They are not part of the architecture
they check.

- [Test-Repository.ps1](Test-Repository.ps1) checks four things:
  - every document carries a valid status header;
  - every link and anchor resolves;
  - the canon is named the same way everywhere;
  - every proof passes.

  Run it with `pwsh Scripts/Test-Repository.ps1` before committing. CI runs it
  on every push (`.github/workflows/repository-check.yml`).
- [Test-CanonAuthority.ps1](Test-CanonAuthority.ps1) checks that every commit
  in a range which changes canon, CODEOWNERS, these two checks or a workflow
  declares `Canon-Authority: human | review | delegated`. A delegated commit
  must quote its `Delegation:`, and clearing `decided_by_assistant` is left to
  a human. CI runs it on the commits of each push or pull request, using the
  script as it stood before them.
- [Proof.ps1](Proof.ps1) is the helper every `*.Tests.ps1` proof uses;
  [_Tests/](_Tests/CanonAuthority.Tests.ps1) holds the proofs of these
  scripts.
