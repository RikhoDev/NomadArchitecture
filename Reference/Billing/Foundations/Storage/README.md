---
status: non-canon
kind: guide
origin: ai
---

# Storage

**Promise.** Keep invoices for the life of the process, safely under
concurrent use, and find them again by identity.

**Residents.** [InMemoryInvoiceStore.cs](InMemoryInvoiceStore.cs).

**Relationships.** It implements `IInvoiceStore`, the contract the
[Invoicing Feature](../../Features/Invoicing/README.md) declares. It depends on
that contract and on nothing else in the system. Hosts choose it.

**Proof.** [_Tests/InMemoryInvoiceStoreTests.cs](_Tests/InMemoryInvoiceStoreTests.cs).

**Status.** In memory only. A database store would be another Foundation
fulfilling the same contract, chosen by the Host, with Invoicing unchanged.
