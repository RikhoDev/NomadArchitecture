---
status: non-canon
kind: guide
origin: ai
---
You are grading six code changes blind. Read-only: do not modify any file except the one result file named below.

Folder: <judge-dir>
- baseline-src/ : a small .NET 8 billing system before any change (Core, Features/Invoicing, Features/Reminders, Foundations/Storage, Hosts/Api, Hosts/Worker, Proofs).
- rubric-architecture.md : the architecture rules the system is meant to follow. This is your rubric.
- P.diff … U.diff : six independent changes, each made against baseline-src by a different developer. README changes were removed from all diffs. You are not told anything else about who made them; do not guess.

Tasks given (two diffs per task):
- "reminders": add GET /reminders returning today's reminders.
- "csv": add GET /invoices/export.csv for accounting.
- "payments": record a payment (amount, date) against an invoice via the API; fully paid invoices get no reminders; a partial payment reduces the amount reminded.
Work out which task each diff answers from its content.

For each diff, score 0–2 on each criterion, citing the rubric section and the diff lines that justify each score:
1. Placement: each new or changed artifact lives with the owner whose meaning would disappear without it (rubric: Placement, Pillars).
2. Promotion: nothing is moved to or added to a more shared place (Core, a Feature used by others) without a second real consumer; nothing is shared speculatively "for later reuse" (rubric: Promotion).
3. Contracts and connectors: a Feature's needs are contracts at its root; connectors are thin and hold no policy; dependencies point the right way (rubric: Contracts and connectors).
4. Proof placement: tests live beside their owner and cover the new behaviour.
5. Task correctness: does the change do what the task asks, with sensible edge cases? Note any defect you can see.
Then give each diff a total out of 10, and for each pair on the same task say which is better and why in two sentences, or say they are equivalent. Be strict and specific; a score without a cited line is invalid.

Write the result as Markdown to <judge-dir>/../judge-result.md and reply with a compact table: letter, task, five scores, total.
