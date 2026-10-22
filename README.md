# NomadArchitecture

**An architecture method for keeping intent alive in software that people and
AI assistants build together. The structure carries what the system is, its
stories carry why, and a small canon says what binds, who decided it, and what
proves it. The repository says all of this itself.**

> **This branch is a sprout beside `main`.** `main` holds the spark that lit
> the fire, and stays as it is. This branch grows next to it and earns a name
> only by its evidence; see
> [A sprout beside the spark](__Docs/_Mirages/2610-02-A-Sprout-Beside-The-Spark-Mirage.md).

---

## The problem it addresses

Intent leaks. It leaks from one project to another, when a capability cannot
move without its whole system. It leaks from one AI session to the next, which
remembers nothing and fills the gap with something plausible. It leaks from
the architect who draws the map and leaves, to the team that then decides
alone. And it leaks from the people who leave.

AI assistants make every one of these leaks faster. They now draft a large
share of code, documentation and design decisions, quickly and plausibly.
Plausible is not accountable. A generated rule reads like an agreed one, a
passing test reads like approval, and what one session decided, the next one
never learns. Over time:

- **Authority blurs.** Nobody can say which guidance binds, or who approved it.
- **Architecture erodes.** Structure decays because placement is never
  checked, only reviewed, and AI-sized changes outrun review.
- **Knowledge leaks.** The reasons behind decisions live in chat logs and in
  the heads of people who leave.
- **Provenance is lost.** When audit asks which parts an AI wrote, and on whose
  authority they took effect, there is no record.

## What it gives you

| Concern | Mechanism | Held by |
|---|---|---|
| What binds | A small, listed canon; every document declares its status and kind | [`Test-Repository`](Scripts/README.md) in CI |
| Who decided | Named canon owners; every canon commit declares `human`, `review` or `delegated` authority; the assistant's decisions stay marked until a human reads them | [`Test-CanonAuthority`](Scripts/README.md) in CI, and code-owner review |
| AI provenance | Every document states its origin; AI conversations are kept as Trails, apart from the rules they produced | `Test-Repository` in CI |
| Architecture that holds | Hosts compose, Features promise, Foundations implement, Core is earned; dependencies point one way | Conformance tests that fail the build ([Billing](Reference/Billing/README.md)) |
| Capabilities that move | A Feature, less its connectors, needs only Core, so it can join another Host or another system with its contracts and proof | A conformance test per Feature, and a real move ([Rentals](Reference/Rentals/README.md)) |
| Knowledge that survives turnover | Each component answers five questions in its README; each decision keeps its Trail; the repository explains any path on request | [DocReader](Hosts/DocReader/README.md) and the README check |

The rules themselves fit in about 3,200 words: the [canon](__Docs/README.md#canon).

## Where it comes from

It was not designed and then applied. It was grown through explorations, each
of which changed it a little:

- a sample game in July 2025, where Features, Hosts, Foundations and Core
  appeared before the method had a name;
- a first game engine, where the rules met tests and CI;
- a second engine, built as an evidence ground, where one developer and
  several AI assistants kept about 400,000 lines of C# in shape for seven
  months.

Rules were added when the evidence earned them, and withdrawn when it went
against them. The method claims that the same laws apply at every scale: a
Feature, a team and an organisation are each a sovereign unit with its own
boundary, its own memory and its own shared vocabulary. That claim is not yet
shown beyond code. The
[case study](__Docs/_Chronicles/2610-01-How-NomadArchitecture-Was-Grown-Chronicle.md)
tells the lineage, with the evidence and its limits.

## See it working

- **[Reference/Billing](Reference/Billing/README.md)**, a .NET 8 service built
  by the canon:
  - two Hosts (an HTTP API and a scheduled worker);
  - two Features (Invoicing, Reminders);
  - a Foundation with two interchangeable stores, and a Core that had to be
    earned.

  Its git history shows two promotions as they happened. Seven conformance
  rules fail the build when the architecture is broken.
- **[Reference/Rentals](Reference/Rentals/README.md)**, a second system that
  Billing's Reminders joined unchanged, with its proof. The move also showed
  what no test had seen: Reminders' contract spoke Invoicing's language, and it
  was renamed in its own words.
- **[OnboardingTrial](Hosts/OnboardingTrial/README.md)**, a Host that tests
  whether a fresh AI session given this repository builds in its shape,
  against the same code without the documents. One script prepares, runs and
  grades it.
- **[DocReader](Hosts/DocReader/README.md)**, a Host that reads this repository
  back to you: `pwsh Hosts/DocReader/reader.ps1 explain <path>` says whose
  meaning a file carries, who owns it, and where it came from.
- **[nomad-method](https://github.com/RikhoDev/nomad-method)**, a Claude Code
  plugin. It brings the working discipline into every AI session, stops a
  commit that restates canon, and sends changes to an isolated reviewer that
  sees the change but not the author's reasoning.

## Evidence, at its strength

- **Observed in this repository:**
  - CI runs the documents check, the canon-authority check and the reference
    system's 26 tests on every push.
  - The checks have been attacked, and not all of them held. A cold review
    got these past the checks:
    - a `Helpers` folder;
    - policy code in a fake connector namespace;
    - a README of empty headings;
    - a commit that switched the authority check off;
    - a forged `Canon-Authority: human`.

    The first four now fail the build or CI. The forgery is stopped only by
    code-owner review, which this repository's branch protection does not yet
    require. Policy inside a properly placed connector still passes.
    Placement remains a judgement that no check holds.
  - Every isolated review recorded in the
    [canon Trail](__Docs/_Trails/Canon.Trail.20261021.md) found at least one
    defect the author had missed.
  - In a [cold-onboarding pilot](Hosts/OnboardingTrial/README.md), fresh AI
    sessions made three real changes to Billing, one set with the whole
    repository and one with the code alone. Both sets stayed inside the
    pillars. A blind judge preferred the canon arm on all three tasks. On two
    of them the difference was promotion: the code-only arm moved code into a
    shared place for a single caller. This is one run per cell, and the
    judge used the canon as its rubric. Read another way, structure taught
    both arms the pillars, and only the documents carried why to hold back.
- **Observed in the author's earlier repositories:** fifteen months of
  history across a sample game and two engines, summarised in the
  [case study](__Docs/_Chronicles/2610-01-How-NomadArchitecture-Was-Grown-Chronicle.md).
  The largest is one developer's evidence ground, not a production system.
- **Observed in a second repository:** applying the canon to nomad-method found
  six misfits with a plugin platform. One became a canon rule; the others were
  fixed where they belonged or left with reasons.
- **Not yet shown:**
  - adoption by a team other than the author's;
  - measured effects on onboarding time or defect rates;
  - a repeated trial with more than one run per cell;
  - mobility beyond a single move. One Feature has moved, within this
    repository, into a second system built for the purpose.

## Adopt it in steps

Each level stands on its own, and none requires the next. See
[Adoption](__Docs/Adoption.md):

1. **Honest provenance:** status and origin on every document; claims labelled
   as observed, interpreted or unknown.
2. **Governed canon:** named owners, declared authority on every canon change,
   one Trail per decision.
3. **Enforced architecture:** the pillars and placement rules, held by
   conformance tests in your stack.
4. **Assisted review:** the nomad-method plugin and isolated reviews of AI
   changes.

## Read on

- [Practitioner guide](__Docs/Practitioner-Guide.md): the day-to-day, task by
  task.
- [Translation](__Docs/Translation.md): NomadArchitecture's terms beside the
  industry terms they correspond to.
- [Worldview](Worldview.md): the culture behind the method, in its own voice.
- [The canon](__Docs/README.md#canon): what binds, in four files.

---

## ⚠️ A Note on AI Generation
Most of what you’ll find here is **AI‑assisted and AI‑generated**, guided by careful prompt engineering and human curation.  
- The ideas are mine, but the words and drafts often come through AI.  
- I review, refine, and sometimes rewrite, but I don’t pretend this is purely “hand‑crafted.”  
- If that makes you uncomfortable, I understand if you’d rather not proceed.  
- If you’re curious, I invite you to explore with the awareness that this is both a **personal journey** and an **AI experiment**.

The method applies to itself: every document here states its `origin`, and
every canon decision its authority.

---

## ✨ Closing Thought
NomadArchitecture is not a finished framework.  
It’s a journey—an attempt to find the simplest rules that let complex systems stay alive.  

If you’re curious, join in. If you’re skeptical, challenge it. Either way, the conversation helps keep the fire burning. 🔥
