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
| | [Worker](Hosts/Worker/README.md) | a morning digest of invoices falling due |
| Features (WHAT) | [Invoicing](Features/Invoicing/README.md) | issue an invoice, due by its terms, and keep it |
| | [Reminders](Features/Reminders/README.md) | decide whom to remind, how firmly, with a late fee on final notice |
| Foundations (HOW) | [Storage](Foundations/Storage/README.md) | keep invoices, in memory or in a file Hosts share |

| Core (COMMON) | [Money](Core/Money/README.md) | an amount in one currency, never mixed |

Reminders sees Invoicing only through
[its connector](Features/Reminders/_Connectors/OutstandingFromInvoicing.cs).

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
