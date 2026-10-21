---
status: non-canon
kind: guide
origin: ai-assisted
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
