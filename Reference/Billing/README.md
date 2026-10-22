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
  - a Feature could not pack up and leave: outside its `_Connectors` it
    needs more than Core (mobility, the method's first promise);
  - a namespace, folder or type is named for a bucket (`Common`, `Utils`, ...);
  - a namespace disagrees with the folder its code lives in;
  - a resident's README leaves one of the five questions unanswered.

  They hold the shape, not the judgement. Policy inside a properly placed
  connector, or a README whose answers say little, still passes.
- **Proof beside its owner.** Each resident keeps its tests in `_Tests/`.
  Only the [Proofs](Proofs/Proofs.csproj) project compiles them, so
  production assemblies never contain tests.

## Read its history

The system was built one consumer at a time, and each promotion is a commit:

```text
git log --oneline -- Reference/Billing
git log --follow --stat -- Reference/Billing/Features/Invoicing/PaymentTerms.cs
git log --follow -M30% --stat -- Reference/Billing/Core/Money/Money.cs
```

`Money` needs `-M30%`. Its promotion also added `Plus` and `Share` in the same
commit, so git's default rename threshold no longer recognises the move. A
promotion that is a pure move, in a commit of its own, stays traceable with
plain `--follow`; that is what `PaymentTerms` shows. This history keeps the
mistake rather than hiding it.

1. **One Host, one Feature, one Foundation.** Due dates are local to the Api
   Host, `Money` is local to Invoicing, and there is no `Core/`.
2. **A second Host.** The Worker needs due dates too, so `PaymentTerms` is
   promoted from the Api Host into Invoicing. A file store lets two Hosts share
   invoices, and each Host chooses its Foundation. They share it only when both
   are given the same `Billing:StorePath`; without one, the Api keeps invoices
   in memory.
3. **A second Feature.** Reminders needs `Money`, so `Money` is promoted into
   a new `Core/`. Reminders sees Invoicing only through its connector.

Each step passed the conformance tests that the next step might have broken.
