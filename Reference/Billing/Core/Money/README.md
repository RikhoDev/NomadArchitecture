---
status: non-canon
kind: guide
origin: ai
---

# Money

**Promise.** An amount in one currency, rounded to cents half away from zero,
that never mixes currencies.

**Residents.** [Money.cs](Money.cs): the amount, its currency, and the operations that refuse to mix currencies.

**Relationships.** Spoken by the [Invoicing](../../Features/Invoicing/README.md)
and [Reminders](../../Features/Reminders/README.md) Features. It depends on
nothing in the system.

**Proof.** The Invoicing and Reminders proofs exercise it, including rounding,
shares and the refusal to mix currencies.

**Status.** Promoted from Invoicing to Core when Reminders became the second
Feature to speak it. That is the only reason it is here.
