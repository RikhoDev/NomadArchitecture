---
status: non-canon
kind: guide
origin: ai
---

# Worker

**Promise.** Each morning, tell the collections team which invoices fall due
in the coming week, without anyone asking.

```text
dotnet run --project Reference/Billing/Hosts/Worker -- --once true --Billing:StorePath invoices.json
```

**Residents.** [Program.cs](Program.cs) composes the Host and schedules the
digest. [DueSoonDigest.cs](DueSoonDigest.cs) selects and formats it.

**Relationships.** It reads invoices through the
[Invoicing Feature](../../Features/Invoicing/README.md)'s contract, fulfilled
by the file store of the [Storage Foundation](../../Foundations/Storage/README.md),
so it sees what the [Api Host](../Api/README.md) issued.

**Proof.** [_Tests/DueSoonDigestTests.cs](_Tests/DueSoonDigestTests.cs), with a
fixed clock.

**Status.** Its arrival made due dates shared: `PaymentTerms` was promoted from
the Api Host into Invoicing (see the system's history). The digest itself
stays here; no other Host wants it.
