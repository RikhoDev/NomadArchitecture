---
status: non-canon
kind: guide
origin: ai
---

# Billing: a reference system

A small billing service built by NomadArchitecture's
[canon](../../__Docs/README.md#canon), in C# on .NET 8, to show what the rules
look like in an enterprise codebase, and that they can be enforced.

```text
dotnet test Reference/Billing/Billing.sln
dotnet run --project Reference/Billing/Hosts/Api
```

## What it holds

| Pillar | Resident | Promise |
|---|---|---|
| Hosts (WHY) | [Api](Hosts/Api/README.md) | finance staff issue and look up invoices over HTTP |
| Features (WHAT) | [Invoicing](Features/Invoicing/README.md) | issue an invoice and keep it |
| Foundations (HOW) | [Storage](Foundations/Storage/README.md) | keep invoices, safely under concurrent use |

There is no `Core/` yet: no language is shared between two Features.

## How the rules are held

- **Compiler.** Each pillar is a project, and project references point one way:
  Foundations and Hosts reference Features, and never the reverse.
- **Conformance tests.** [Proofs/Architecture](Proofs/Architecture/ConformanceTests.cs)
  fail the build when the architecture is broken:
  - a Feature depends on a Foundation or a Host;
  - Core depends on another pillar;
  - a Feature reaches another Feature outside its `_Connectors`;
  - a namespace is named for a bucket (`Common`, `Utils`, ...);
  - a resident's README does not answer the five questions.
- **Proof beside its owner.** Each resident keeps its tests in `_Tests/`.
  Only the [Proofs](Proofs/Proofs.csproj) project compiles them, so
  production assemblies never contain tests.
