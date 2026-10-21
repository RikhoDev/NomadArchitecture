---
status: non-canon
kind: guide
origin: ai
---

# Cli

**Promise.** Greet someone from the command line:

```text
pwsh examples/Greeting/Hosts/Cli/greet.ps1 -Name Alice
Hello, Alice!
```

**Residents.** [greet.ps1](greet.ps1) loads the
[Greeting Feature](../../Features/Greeting/README.md) and calls it.

**Relationships.** The Host owns the purpose (a person at a terminal) and
decides how a refused promise is shown: a blank name prints
`greet: A greeting needs a name.` and exits with code 2. The Feature does not
know a terminal exists.

**Proof.** The Feature's proof covers the promise. Running the command above is
the only check of this Host; it has no automated proof of its own.

**Status.** Settled.
