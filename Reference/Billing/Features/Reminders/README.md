---
status: non-canon
kind: guide
origin: ai
---

# Reminders

**Promise.** For a given day, decide which customers to remind about overdue
invoices, and how firmly: friendly up to 14 days, firm up to 30, final after
that, with a 2% late fee on the final notice.

**Residents.** [ReminderPolicy.cs](ReminderPolicy.cs) keeps the promise.
[IOutstandingInvoices.cs](IOutstandingInvoices.cs) is the contract it needs.
[_Connectors/OutstandingFromInvoicing.cs](_Connectors/OutstandingFromInvoicing.cs)
fulfils that contract from Invoicing.

**Relationships.** It speaks [Money](../../Core/Money/README.md) from Core. It
needs outstanding invoices in its own vocabulary; its connector is the only
code that sees the [Invoicing Feature](../Invoicing/README.md), and a
conformance test fails if anything else here does. The
[Worker Host](../../Hosts/Worker/README.md) composes it.

**Proof.** [_Tests/ReminderPolicyTests.cs](_Tests/ReminderPolicyTests.cs) for
the policy, with fixed invoices and a fixed clock;
[_Tests/OutstandingFromInvoicingTests.cs](_Tests/OutstandingFromInvoicingTests.cs)
for the connector.

**Status.** Payments are not recorded yet, so every issued invoice counts as
owed. When they are, only the connector changes.
