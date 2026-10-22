---
status: non-canon
kind: trail
origin: ai
trail_of: ../README.md
---

# OnboardingTrial: pilot of 2026-10-22

## Unblinding

The judge saw the letters only. The map, fixed before grading:

| Letter | Run |
|---|---|
| P | control, reminders |
| Q | canon, csv |
| R | control, payments |
| S | canon, reminders |
| T | control, csv |
| U | canon, payments |

Notes made after unblinding, by the trial's designer:

- **The control code still taught the method.** The judge quoted the method
  from code comments that the control arm kept, such as "holds no policy" and
  "Invoicing's types carry no serialization concerns". So the control measured
  how much of the method the code itself carries; it did not measure the
  method's absence.
- **The control csv session promoted speculatively, and said so.** It gave its
  reason as "so a later consumer such as the Worker can reuse it". This is the
  reasoning the promotion rule forbids, and the control arm had no document
  stating that rule.
- **The `Money.Minus` call is debatable.** Keeping the currency check inside
  `Money` has merit, and the judge said so. It still scored the change as
  promotion without a second consumer, because the rubric says so.
- **No session ran the repository's documents check.** `pwsh` was not
  installed for the sessions. All three canon sessions said they could
  not run it; none claimed it passed.

## The judge's report

Verbatim, except that its headings are moved down two levels.

### Blind grading: six changes against baseline-src

Rubric: `judge/rubric-architecture.md`. Line numbers are those of each diff file (`cat -n X.diff`).

| Diff | Task | Placement | Promotion | Contracts/connectors | Proof | Correctness | Total |
|---|---|---|---|---|---|---|---|
| P | reminders | 2 | 2 | 2 | 1 | 2 | 9 |
| S | reminders | 2 | 2 | 2 | 2 | 2 | 10 |
| Q | csv | 2 | 2 | 2 | 2 | 2 | 10 |
| T | csv | 1 | 1 | 2 | 2 | 2 | 8 |
| R | payments | 2 | 1 | 2 | 2 | 2 | 9 |
| U | payments | 2 | 2 | 2 | 2 | 2 | 10 |

---

#### P: reminders

1. **Placement 2.** (Placement, Pillars: "A Host ... decides what it accepts from them".) The HTTP shape `ReminderView` is in the Api Host (P.diff 36-41), and the route is too (26-27). Reminder meaning stays in `ReminderPolicy`, which is unchanged.
2. **Promotion 2.** (Promotion.) Nothing is added to Core or to a Feature. The diff only touches `Hosts/Api/Program.cs` and `ApiTests.cs`.
3. **Contracts/connectors 2.** (Contracts and connectors: "A Host that does not need a Feature does not wire it".) The Api now needs Reminders, so it wires the existing connector and policy in composition (17-18). The endpoint is a one-line projection (26-27) with no policy in it.
4. **Proof 1.** The tests are in `Hosts/Api/_Tests` beside the Host. The main test (64-83) covers a Final reminder with its late fee and an invoice that is not yet due. Weaknesses:
   - `No_reminders_is_an_empty_list` (85-91) uses the shared class fixture with the real system clock and asserts the exact string `"[]"`. It passes only because the other tests in the class happen to issue invoices that are not yet overdue, so it depends on order and fixture state.
   - The main test adds a second `TimeProvider` without removing the first (69). It also writes through whatever `IInvoiceStore` the Host chose (70), so with `Billing:StorePath` set it would write to a real file.
   - Friendly and Firm levels and the ordering are not exercised through the endpoint.
5. **Correctness 2.** `GET /reminders` returns `ReminderPolicy.Due()` for today's clock date (26-27). When nothing is due it returns an empty JSON array. Level is serialised as a name, and amount and currency are flattened (38-40). No defect seen.

#### S: reminders

1. **Placement 2.** Same placement as P (S lines in `S.diff` 270-271 and 280-285). `ReminderView` and the route are Host-local.
2. **Promotion 2.** Nothing is promoted. Only the Api Host and its tests change.
3. **Contracts/connectors 2.** The composition wires the connector (260-262), and its comment states the seam: "Reminders sees Invoicing only through its connector." The endpoint is a thin projection (270-271).
4. **Proof 2.** The tests sit beside the Host.
   - `Lists_todays_reminders_most_overdue_first...` (310-332) covers all three levels, the most-overdue-first ordering, days overdue, the late fee on Final only, and an invoice that is not yet due.
   - The empty case (334-344) is deterministic, with its own clock and store.
   - The `Host(...)` helper replaces both the clock and the store with `RemoveAll` (346-351), so the tests are isolated from the fixture and from configuration.
5. **Correctness 2.** The production code is identical to P's, and it is correct.

**P vs S:** The production code is the same: the same view, wiring and endpoint, with S adding only a comment. S is better because its proofs are isolated and complete: they replace the clock and the store and cover every level and the ordering. P's empty-list test leans on the shared fixture and the wall clock.

---

#### Q: csv

1. **Placement 2.** (Placement, Sovereignty test; Pillars: Host "decides what it accepts".) The CSV format lives in `Hosts/Api/InvoiceCsv.cs` (93-144). Its doc comment states the test: "Host-local: the format is this Host's answer to this audience, and only this Host wants it" (106-108). This matches the baseline precedent `Hosts/Worker/DueSoonDigest.cs`, which is "Host-local: it is this Host's purpose". If the Api Host vanished, nobody else would need this format.
2. **Promotion 2.** (Promotion: "Two independent consumers are enough".) There is one consumer, so nothing goes into Invoicing or Core. The Feature's public surface is unchanged.
3. **Contracts/connectors 2.** The endpoint reads through Invoicing's own contract, `IInvoiceStore.All()`, and passes the result to the Host-local formatter (161-162). Dependencies run Host to Feature. The Feature gains no format concern.
4. **Proof 2.** `Hosts/Api/_Tests/InvoiceCsvTests.cs` sits beside the owner (192-243). It covers:
   - the exact header and row;
   - the empty export;
   - ordering;
   - quoting of commas, quotes and newlines;
   - formula defusing (`=`, `@`).

   An end-to-end Api test (176-190) checks the status, the `text/csv` media type and a quoted row.
5. **Correctness 2.**
   - Output follows RFC 4180, with CRLF line ends (116, 124) and quoting by the rules (140-142).
   - Amounts and dates are culture-invariant (121, 123-124).
   - Formula-injection prefixes are defused (135-138).
   - The order is deterministic, with ties broken by customer and then id (117).

   Minor points:
   - No charset is stated in the content type (162). `Results.Text` defaults to UTF-8, so this works, but it is not explicit.
   - No test runs under a non-invariant culture.
   - There is no Excel BOM.

#### T: csv

1. **Placement 1.** (Placement, Sovereignty test; Pillars.) The export is placed at the Invoicing Feature root as `Features/Invoicing/InvoiceCsvExport.cs` (353-404). An accounting CSV is a delivery format for one audience of one Host, and Invoicing's promise ("Issues invoices") does not lose meaning without it. The baseline's `JsonFileInvoiceStore` says explicitly that "Invoicing's types carry no serialization concerns", and T adds one to the Feature. The Host-local precedent (`DueSoonDigest`) shows where single-Host views go.
2. **Promotion 1.** (Promotion: "Two independent consumers are enough ... Do not promote ... before the seam was proven".) A new `public static class` (369) is added to a Feature that other code already uses (the Reminders connector and the Worker Host). Only the Api consumes it (478-479). It becomes a public Feature promise without a second consumer.
3. **Contracts/connectors 2.** Dependencies still point the right way: the Feature depends only on its own `Invoice`, and the Host calls the Feature (478-479). The endpoint is thin, and no connector is involved.
4. **Proof 2.** The tests are in `Features/Invoicing/_Tests/InvoiceCsvExportTests.cs`, beside the code's chosen owner (405-469). They cover the exact row, the empty export, quoting, formula defusing and a `de-DE` culture check (455-468). An Api integration test (493-506) checks status, media type and the row.
5. **Correctness 2.** Output follows RFC 4180, with quoting (400-402), defusing (395-398), invariant formatting (381-384) and an explicit `charset=utf-8` (479). Rows rely on the store's ordering from `All()`, which both baseline stores sort by `IssuedOn` then `Id`. That is acceptable but implicit. No defect seen.

**Q vs T:** The behaviour is essentially equivalent; T is marginally better on details, with the explicit charset and a culture test. Q is better on architecture: it keeps a single-audience format in the Host that wants it, as the `DueSoonDigest` precedent does. T makes it a public Invoicing promise with one consumer, which fails both the Sovereignty test and the two-consumer Promotion rule.

---

#### R: payments

1. **Placement 2.** (Placement; Contracts and connectors: "Foundations implement Feature contracts".) The pieces are placed by owner:
   - Invoicing owns the payment meaning: `Payment` (58-69), `PaymentRecorder` (70-114), `InvoiceBalance` (42-57) and the need `IPaymentStore` (22-41).
   - Foundations hold the mechanisms `InMemoryPaymentStore` and `JsonFilePaymentStore` (235-326).
   - The Api Host holds the HTTP shapes `PaymentRequest` and `PaymentView` (416-422).
2. **Promotion 1.** (Promotion: "Core, only when common language emerges across pillars"; "Two independent consumers".) `Money.Minus` is added to Core (1-21), and its only caller is Invoicing's `InvoiceBalance` (56). Reminders does not use it. Keeping the currency invariant inside `Money` can be defended. Still, it adds to the most shared pillar for one consumer, and U shows the task can be done without touching Core.
3. **Contracts/connectors 2.**
   - The new need is a contract at the Invoicing root (`IPaymentStore`, 34-41).
   - Foundations implement it (247, 281). Dependencies point toward the contract.
   - The connector stays thin (184-197). Invoicing computes the balance ("Invoicing says what the balance is", 182), and the connector only maps it and drops zero balances, which is what "outstanding" means in Reminders' vocabulary.
   - The Host wires both stores in both Hosts (383-385, 465).
4. **Proof 2.** Each proof sits with its owner:
   - Feature: `PaymentRecorderTests` (115-169) covers partial payment, exact payoff, and refusals for an unknown invoice, zero, wrong currency, a date before issue, and overpayment, with nothing stored after a refusal.
   - Connector: a test for a partial and a full payment as Reminders sees them (216-233).
   - Foundation: store tests, including sharing through the file (327-374).
   - Api: an endpoint test for 201, 400 and 404 (436-455).
5. **Correctness 2.** The task is met: payments are recorded with an amount and date through `POST /invoices/{id}/payments` (395-410). Fully paid invoices drop out of reminders, and a partial payment lowers the amount reminded (193-196, 229-232). Minor defects:
   - A payment dated in the future is accepted, because the recorder has no clock (84-113).
   - The balance check and the add are not atomic (105-111), so two concurrent payments could overpay.
   - The `Created` location points to the invoice, not to the payment (400).
   - The API offers no way to read the balance.

#### U: payments

1. **Placement 2.** (Placement.) `Payment`, `PaymentRecorder` and `InvoiceBalance` are at the Invoicing root (15-87). Payment persistence is in the existing Foundation stores (212-301). The HTTP shapes are in the Api Host (404-415).
2. **Promotion 2.** (Promotion.) Nothing is added to Core. The balance is computed inside Invoicing (28-29). No new shared abstraction is introduced.
3. **Contracts/connectors 2.** (Contracts and connectors.)
   - Invoicing's own store contract is widened with `AddPayment` and `PaymentsFor` (10-13). Invoicing owns that meaning, and both Foundations implement it (227-246, 273-297).
   - The connector stays thin (177-184). Its comment states that "Owed is Invoicing's meaning (InvoiceBalance); this only hands over what is left".
   - No extra Host wiring is needed: the Worker is unchanged, and the Api registers only `PaymentRecorder` (362).
4. **Proof 2.** Each proof sits with its owner:
   - Feature: `PaymentRecorderTests` (101-166) covers partial and full payment, refusals (zero, negative, over the balance, before issue), overpayment after an earlier payment, and an unknown invoice.
   - Connector: a test for part-paid and fully paid invoices (195-210).
   - Both stores have tests, including backward compatibility with invoice files written before payments existed (335-349).
   - Api: tests for the balance on the payment response and on `GET /invoices/{id}`, plus 400 and 404 (426-452).
   - The test fake was updated (96-97).
5. **Correctness 2.** The task is met: `POST /invoices/{id}/payments` takes `{amount, date}` (382-397, 404). The connector drops paid invoices and reduces part-paid ones (181-184). Old JSON files stay readable (257-258). The balance is shown on the invoice (408-414). Minor defects:
   - Future-dated payments are accepted (62-86).
   - The check and the add are not atomic (78-84).
   - `InvoiceBalance` subtracts raw decimals (29), which sidesteps `Money`'s currency guard. This is safe only because payments always take the invoice's currency (66, 295).
   - `Payment` has no identity, so two identical payments cannot be told apart.
   - The connector re-reads the JSON file once per invoice (182), which is an N+1 pattern.

**R vs U:** Both put payment meaning in Invoicing, keep the connector thin and prove each owner. U is better on Promotion because it does not grow Core (`Money.Minus` in R has a single consumer). U is also better on the task itself: it exposes the balance through the API and keeps old store files readable, and it needs no Worker rewiring. R's separate `IPaymentStore` is arguably cleaner, and it reads payments once rather than once per invoice, but that does not outweigh the needless Core change.
