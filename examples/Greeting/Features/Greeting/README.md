---
status: non-canon
kind: guide
origin: ai
---

# Greeting

**Promise.** Given a name, return a greeting for that person. A blank name is
refused, because "Hello, !" greets no one.

**Residents.** [Greeting.ps1](Greeting.ps1) holds the whole promise in
`Get-Greeting`. The promise is small, so the Feature root needs nothing else.

**Relationships.** It is used by the [Cli Host](../../Hosts/Cli/README.md). It
uses nothing: there is no Core language and no Foundation mechanism, because
no second consumer exists yet. There is no `_Connectors/` either, because no
seam exists to wire; the Host calls the promise directly.

**Proof.** [_Tests/Greeting.Tests.ps1](_Tests/Greeting.Tests.ps1) checks the
three claims above: the greeting, trimming of the name, and refusal of a blank
one. `Scripts/Test-Repository.ps1` runs it on every check.

**Status.** Its proof passes. Until October 2026 the whole Feature lived in
`examples/MinimalFeature/Features/Greeting/_Connectors/GreetingConnector.ps1`,
which the
[connector rules](../../../../__Docs__/Architecture.md#contracts-and-connectors)
no longer allow. It was moved to the Feature root and given a proof. The
earlier shape is in git history.
