---
status: non-canon
kind: guide
origin: ai
---

# Invoicing

**Promise.** Issue an invoice to a customer for an amount of money, and keep
it. An invoice with no customer, or for nothing, is refused.

**Residents.** [InvoiceIssuer.cs](InvoiceIssuer.cs) keeps the promise.
[Invoice.cs](Invoice.cs) and [Money.cs](Money.cs) are its vocabulary.
[IInvoiceStore.cs](IInvoiceStore.cs) is the contract it needs fulfilled.

**Relationships.** It needs an `IInvoiceStore`; the Storage Foundation provides
one. It needs the time from .NET's `TimeProvider`. It does not know that HTTP
exists, or where invoices are kept.

**Proof.** [_Tests/InvoiceIssuerTests.cs](_Tests/InvoiceIssuerTests.cs), with a
fake store and a fixed clock.

**Status.** `Money` lives here because Invoicing is its only user.
