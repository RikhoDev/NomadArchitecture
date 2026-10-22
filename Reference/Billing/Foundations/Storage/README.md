---
status: non-canon
kind: guide
origin: ai
---

# Storage

**Promise.** Keep invoices and find them again by identity: in memory for one
process, or in a JSON file that several Hosts on one machine share.

**Residents.** [InMemoryInvoiceStore.cs](InMemoryInvoiceStore.cs) and
[JsonFileInvoiceStore.cs](JsonFileInvoiceStore.cs). Both implement one
contract; the file's JSON shape belongs to this Foundation.

**Relationships.** It implements `IInvoiceStore`, the contract the
[Invoicing Feature](../../Features/Invoicing/README.md) declares. It depends on
that contract and on nothing else in the system. Hosts choose it.

**Proof.** [_Tests/](_Tests/InMemoryInvoiceStoreTests.cs), one file per store.

**Status.** The file store arrived with the Worker Host, which needed to see
the Api Host's invoices. A database store would be a third implementation of
the same contract; Invoicing would not change. The file store first locked only
within one process, so two Hosts writing at once could lose or corrupt
invoices. A review found it; every access now holds a lock file, and a proof
writes from several stores at once.
