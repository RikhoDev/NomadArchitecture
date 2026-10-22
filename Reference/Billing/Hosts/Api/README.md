---
status: non-canon
kind: guide
origin: ai
---

# Api

**Promise.** Let finance staff issue invoices and look them up over HTTP:
`POST /invoices` and `GET /invoices/{id}`. A refused invoice answers `400`
with the reason.

**Residents.** [Program.cs](Program.cs) composes the system, chooses the store
(the shared file when `Billing:StorePath` is set, memory otherwise) and maps
the routes.

**Relationships.** It composes the
[Invoicing Feature](../../Features/Invoicing/README.md) with the
[Storage Foundation](../../Foundations/Storage/README.md), and owns everything
about HTTP: routes, status codes, the shape of the JSON.

**Proof.** [_Tests/ApiTests.cs](_Tests/ApiTests.cs) drives the real Host
through HTTP.

**Status.** `PaymentTerms` lived here until the Worker Host needed due dates
too; it was then promoted into Invoicing.
