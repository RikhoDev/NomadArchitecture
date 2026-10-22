---
status: non-canon
kind: guide
origin: ai
---

# OnboardingTrial

**Promise.** Test, repeatably, whether a fresh AI session given only this
repository builds in the canon's shape, and record what it does when it
does not. It tests the claim behind [Adoption](../../__Docs/Adoption.md)
levels 1 to 3: that the documents, not just the code, carry the method.

```text
Hosts/OnboardingTrial/trial.sh prepare <work-dir>   six copies, baselines checked
Hosts/OnboardingTrial/trial.sh run     <work-dir>   one headless session per copy
Hosts/OnboardingTrial/trial.sh grade   <work-dir>   build, tests, conformance, blinded diffs
```

**Residents.**

- [trial.sh](trial.sh): the Host. It owns the protocol below: the arms, the
  tasks, the prompt, the grading and the blinding.
- [judge-prompt.md](judge-prompt.md): the fixed rubric given to the blind
  judge.
- [_Trails/](_Trails/README.Trail.20261022.md): the judge's full report for
  each run, and the notes made when unblinding it.

**Relationships.** It reads the repository as committed (`git archive HEAD`)
and composes nothing else. It uses [Reference/Billing](../../Reference/Billing/README.md)
as the system under change, Billing's conformance tests as the mechanical
check, and [Architecture](../../__Docs/Architecture.md) as the judge's rubric.

**Proof.** `prepare` fails unless every copy builds and its tests pass before
any session starts. `grade` runs the same conformance rules on both arms.
Running `prepare` then `grade` with no sessions is the dry run: every diff
comes out empty.

**Status.** One pilot, recorded below. Not yet repeated.

## Protocol

**Two arms, three tasks, one session each.**

- **Canon arm:** the whole repository: the canon, `AGENTS.md` and
  `CLAUDE.md`, the READMEs and the conformance tests.
- **Control arm:** Billing's code alone, with the method's documents and checks
  removed:
  - no READMEs;
  - no conformance tests;
  - no comments in the build files.

  Code comments and the folder layout stay. The control is therefore not "no
  method": it is the method as far as the code itself carries it.

The three tasks are real changes to Billing:

- **payments:** record payments, and stop reminders for paid invoices;
- **reminders:** `GET /reminders`;
- **csv:** `GET /invoices/export.csv`.

The prompt is the same in both arms, apart from the solution's path. It asks
the session to keep the build and tests passing, add tests, decide without
asking, and say why each file lives where it does. Plugins are disabled in
every copy.

**Grading, the same for both arms:**

1. The session's own build and tests.
2. Billing's conformance rules, copied into the control results first. The
   README rule is left out, because the control has no READMEs.
3. A blind judge: a fresh session given the six diffs, shuffled afresh and
   relabelled, without README changes, plus the baseline code and the
   [rubric](judge-prompt.md). It scores placement, promotion, contracts and
   connectors, proof, and correctness, 0 to 2 each.

## Pilot, 2026-10-22

| Task | Arm | Tests after (baseline) | Conformance 1–5 | Judge /10 | READMEs updated |
|---|---|---|---|---|---|
| payments | canon | 37 (24) | pass | 10 | 5 |
| payments | control | 25 (18) | pass | 9 | none to update |
| reminders | canon | 26 (24) | pass | 10 | 3 |
| reminders | control | 20 (18) | pass | 9 | none to update |
| csv | canon | 33 (24) | pass | 10 | 1 |
| csv | control | 24 (18) | pass | 8 | none to update |

The canon arm's baseline has six more tests: the conformance tests.

**Observed:**

- **The floor held in both arms.** All six sessions finished, built and passed
  their own tests. None broke a dependency or naming rule. In this system, the
  code's layout and comments were enough to keep a session inside the
  pillars.
- **The difference was promotion.** The judge marked two artifacts as moved
  to a shared place too early, both in the control arm:
  - the CSV format was put in the Invoicing Feature "so a later consumer such
    as the Worker can reuse it";
  - `Money.Minus` was added to Core for a single caller.

  The canon arm kept the CSV format in the Api Host, citing the
  [promotion rule](../../__Docs/Architecture.md#promotion), and left Core
  alone.
- **The reminders pair differed only in its tests.** The production code was
  the same.
- **Only the canon arm kept the documentation current:** nine READMEs updated
  across three tasks. Both payments sessions noticed the same open issue (the
  due-soon digest still lists paid invoices). The canon arm recorded it in the
  Invoicing README; the control arm mentioned it only in its reply.

**Not shown, and why:**

- **One run per cell.** Each row is one observation, not a rate. A repeat could
  reverse any pair.
- **The judge reads the canon as its rubric.** It measures conformance to this
  method, not quality in general. It is also the same model family as the
  sessions it grades.
- **The scale is coarse.** The judge noted defects in both payments runs
  without docking a point, such as future-dated payments and a check and save
  that are not atomic. The [Trail](_Trails/README.Trail.20261022.md) lists
  them all.
- **The same author built the system, wrote the canon and designed the
  trial,** in one session.
- **Billing is small.** It shows whether a session follows the method, not
  whether the method pays off at scale.
- **The rules were weaker then.** The pilot was graded with five conformance
  rules. A later review showed they could be dodged, and the rules were
  hardened. All six pilot results also pass the hardened rules.

**Since the pilot:** a cold review found that a repeat would contaminate
itself. The canon arm would read this folder, with its results, rubric and
verdicts. `prepare` now removes this Host from the canon copies, and drops the
root README's mentions of it. The pilot itself was not affected, because this
Host did not exist when it ran. The blind mapping, fixed in the pilot, is now
drawn afresh on each `grade`.

To repeat it, run the three commands above in a new work folder. Give the
reviewer `judge/prompt.txt`, unblind with `blind-map.txt`, and add the result
as a new pilot section here.
