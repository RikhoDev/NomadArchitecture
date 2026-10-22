---
status: non-canon
kind: guide
origin: ai
---

# Rentals: a second system, for Reminders to join

A tool-rental shop's counter. It exists to test the canon's first promise,
mobility: a Feature, less its `_Connectors`, needs only Core, so it can join
another system with its contracts, its proof and its Trail. Billing's
[Reminders](../Billing/Features/Reminders/README.md) joined it, unchanged.

```text
dotnet test Reference/Rentals/Rentals.sln
dotnet run --project Reference/Rentals/Hosts/Desk -- 2026-10-22
```

## What it holds

| Pillar | Resident | Promise |
|---|---|---|
| Hosts (WHY) | [Desk](Hosts/Desk/README.md) | each morning, whom to chase for tools not yet back |
| Features (WHAT) | [Loans](Features/Loans/README.md) | lend a tool until a date, take it back, say what is still out |
| | [Reminders](Features/Reminders/README.md) | joined from Billing: whom to remind, how firmly, with a late fee on final notice |

It has no Core or Foundations of its own. It speaks Billing's Core, because
Reminders speaks `Money`, and nothing here has needed storage beyond the desk.

## How Reminders joined

- **Its body came unchanged.** The Features project compiles
  `Billing/Features/Reminders/*.cs` from where it lives, less its
  `_Connectors` and `_Tests`. No file of it was copied or edited.
- **Its proof came with it.** The Proofs project compiles Billing's
  `ReminderPolicyTests.cs` from where it lives, and it passes here.
- **Its connector is local.** [OutstandingFromLoans](Features/Reminders/_Connectors/OutstandingFromLoans.cs)
  is this system's seam between Loans and Reminders. Billing keeps its own.
- **Core came along.** Reminders cannot leave without the language it speaks,
  so this system references Billing's Core. Across teams, Core would travel
  as a package.

## What the move showed

The mobility test held the shape, and the move worked. The move also showed
two things that no test had seen.

- **Reminders spoke its birthplace's language.** Its contract was
  `OutstandingInvoice`, with an `InvoiceId`, so this system's connector had to
  call a late tool an invoice. The meaning Reminders owns, "an amount a
  customer owes", is not Invoicing's. The commit after the move renamed the
  contract in Reminders' own words: `AmountOwed`, from `IAmountsOwed`.
  Billing's connector now translates invoices, as this one translates loans.
- **Its namespace carries its birthplace.** Reminders is still
  `Billing.Features.Reminders` here. The family keeps its name in the new
  convoy. It is harmless to the build, but a reader at the rental counter sees
  "Billing".
