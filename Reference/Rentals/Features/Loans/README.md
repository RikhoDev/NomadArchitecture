---
status: non-canon
kind: guide
origin: ai
---

# Loans

**Promise.** Lend a tool to a customer until a date, take it back, and say
which loans are still out.

**Residents.** [Loan.cs](Loan.cs) is a loan and its late charge;
[LoanDesk.cs](LoanDesk.cs) keeps the promise, and keeps its loans itself.

**Relationships.** It speaks `Money` from Billing's Core and knows nothing of
Reminders. Reminders reads it only through this system's connector.

**Proof.** [_Tests/LoanDeskTests.cs](_Tests/LoanDeskTests.cs): a returned tool
is no longer out, and a loan needs a customer and a tool.

**Status.** In memory only, because nothing here needs more yet. A Foundation
would be earned the day a second Host needs the same loans.
