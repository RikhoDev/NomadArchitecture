---
status: non-canon
kind: trail
origin: ai-assisted
trail_of: ../Evidence-And-Authority.md
---

# Canon governance for teams, 2026-10-22

> **Context:** after a cold audit judged NomadArchitecture "not yet a team
> method", the human asked for more than cheap changes: "I don't want cheap
> changes, I want a presentable and defensible NomadArchitecture that makes
> sense for enterprise value addition, if you see what I mean." The assistant
> proposed a five-phase programme; this is phase 2, governance as mechanism.
> **Author:** Claude Code, for Eric (Shaman).

## What the audit found

The cold audit found authority to be the weakest part at team scale:
- "the human" meant one person;
- there was no rule for disagreement;
- delegation could drift into "a human typed proceed";
- nothing checked any of it.

## What changed

- **Canon owners are named in a file.** `.github/CODEOWNERS` lists them, and
  it is canon-owned itself, so changing who decides is a reviewed change. The
  checks that hold the canon are owned with it.
- **Every canon commit declares its authority** (`human`, `review` or
  `delegated` with its quote), and `Scripts/Test-CanonAuthority.ps1` fails CI
  otherwise. Eight proof claims cover it.
- **Delegation covers what it names,** and only a `human` commit clears
  `decided_by_assistant`.
- **Disagreement freezes the canon.** One owner's request for changes blocks
  the merge, and the question waits in the change's Trail.
- **One Trail per canon change** (`Canon-<Topic>.Trail.<date>.md`). This file
  is the first.

## What the repository cannot do for itself

Code-owner review binds only if branch protection requires it on the default
branch. That is a repository setting, which the assistant cannot change. Until
the human enables it, the trailers are checked, but approval is not.

## Lessons from building it

- A PowerShell helper named `Git` called itself, because function names
  ignore case.
- The proof helper's parameter `$Check` silently shadowed a test's `$check`
  variable, so every claim ran against the wrong thing. The helper's
  parameter is now `$Evidence`.
