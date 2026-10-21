---
status: non-canon
kind: guide
origin: ai
---

# Greeting example

The smallest NomadArchitecture system that follows the
[canon](../../__Docs__/README.md#canon) and proves it.

```text
Greeting/
  Hosts/
    Cli/                 WHY: a person greets someone from a terminal
      greet.ps1
      README.md
  Features/
    Greeting/            WHAT: the greeting promise
      Greeting.ps1
      README.md
      _Tests/
        Greeting.Tests.ps1
```

Read it in this order: the [Feature](Features/Greeting/README.md), then the
[Host](Hosts/Cli/README.md).

Some pillars are missing on purpose. There are no `Core/` or `Foundations/`
folders: nothing here is shared yet, and in NomadArchitecture a pillar is
earned through use, not created in advance.

Requires PowerShell 7 (`pwsh`).
