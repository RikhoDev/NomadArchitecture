---
status: non-canon
kind: guide
origin: ai
---

# Invoicing

**Promise.** Issue an invoice to a customer for an amount of money, due on a
date set by its payment terms, and keep it. An invoice with no customer, for
nothing, or on terms beyond a year, is refused.

**Residents.** [InvoiceIssuer.cs](InvoiceIssuer.cs) keeps the promise.
[Invoice.cs](Invoice.cs), [Money.cs](Money.cs) and
[PaymentTerms.cs](PaymentTerms.cs) are its vocabulary.
[IInvoiceStore.cs](IInvoiceStore.cs) is the contract it needs fulfilled.

**Relationships.** It needs an `IInvoiceStore`; the Storage Foundation provides
one. It needs the time from .NET's `TimeProvider`. It does not know that HTTP
exists, or where invoices are kept.

**Proof.** [_Tests/InvoiceIssuerTests.cs](_Tests/InvoiceIssuerTests.cs), with a
fake store and a fixed clock.

**Status.** `PaymentTerms` was promoted here from the Api Host when the Worker
Host became the second consumer of due dates. `Money` lives here because
Invoicing is its only user.
