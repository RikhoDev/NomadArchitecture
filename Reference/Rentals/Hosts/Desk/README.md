---
status: non-canon
kind: guide
origin: ai
---

# Desk

**Promise.** At the rental counter, list each morning the customers to chase
for tools not yet back, how firmly, and for how much.

**Residents.** [Program.cs](Program.cs): it composes Loans and Reminders
through this system's connector, with a few sample loans and a fixed clock
for the day given.

**Relationships.** It composes both Features and owns only the purpose and
what is printed. The reminder policy stays with Reminders.

**Proof.** The Features it composes prove their promises. The Desk itself is
checked by running it: `dotnet run --project Reference/Rentals/Hosts/Desk --
2026-10-22`.

**Status.** A demonstration Host: its loans are samples, not a store.
