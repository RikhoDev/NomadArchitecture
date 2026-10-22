---
status: non-canon
kind: guide
origin: ai
---

# Reminders (joined from Billing)

**Promise.** The same as in [Billing](../../../Billing/Features/Reminders/README.md):
for a given day, decide whom to remind and how firmly, with a late fee on the
final notice.

**Residents.** Only what is local to this system lives here:
[_Connectors/OutstandingFromLoans.cs](_Connectors/OutstandingFromLoans.cs),
which hands Reminders the tools still out. Its body is compiled from Billing's
folder, unchanged.

**Relationships.** It needs what is owed in its own vocabulary; the connector
is the only code here that sees Loans. It speaks `Money` from Billing's Core.
The [Desk Host](../../Hosts/Desk/README.md) composes it.

**Proof.** Billing's `ReminderPolicyTests.cs`, compiled from where it lives,
and [_Tests/OutstandingFromLoansTests.cs](_Tests/OutstandingFromLoansTests.cs)
for this system's seam.

**Status.** It joined on 2026-10-22, as the first real move of a Feature
between systems. See [what the move showed](../../README.md#what-the-move-showed).
