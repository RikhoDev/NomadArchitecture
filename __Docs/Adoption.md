---
status: non-canon
kind: guide
origin: ai
---

# Adoption

How a team adopts NomadArchitecture one level at a time. Each level pays for
itself without the next. This guide applies the [canon](README.md#canon) and
adds no rules.

Costs are the assistant's estimates for a team new to the method, not
measurements. The returns are what each level makes checkable, not promised
outcomes.

## Level 1: Honest provenance

**What it is.** Every document says what it is and where it came from. Every
claim says how strong it is.

- A status header on every Markdown file: `status`, `kind`, `origin`
  ([Status header](README.md#status-header)).
- AI conversations kept as Trails, apart from the documents they produced
  ([Trails](README.md#trails-hold-the-conversation)).
- Claims stated as observed, interpreted or unknown
  ([Claims](Evidence-And-Authority.md#claims)).
- An `AGENTS.md` that sends every assistant session to those rules.

**What to copy.** The header format, the `AGENTS.md` pattern, and the header
and link checks of [`Scripts/Test-Repository.ps1`](../Scripts/README.md).

**Cost.** About a day to add headers to an existing documentation set; minutes
per new document after that.

**Return.** Anyone, and any audit, can tell an AI draft from an agreed rule,
and an observation from an interpretation. Links and anchors stop rotting
silently.

**Does not give.** Any guarantee that the content is right.

## Level 2: Governed canon

**What it is.** A short list of documents binds, and every change to them
records who authorized it.

- A canon list (`.nomad-method/canon`) and an index that agrees with it.
- Canon owners in `.github/CODEOWNERS`, and branch protection that requires
  their review.
- A `Canon-Authority:` trailer on every canon commit, checked by
  [`Scripts/Test-CanonAuthority.ps1`](../Scripts/README.md)
  ([Authority](Evidence-And-Authority.md#authority)).
- One Trail per canon change.

**What to copy.** CODEOWNERS, both scripts, and the `authority` job of
`.github/workflows/repository-check.yml`.

**Cost.** About a week: choosing the canon, naming owners, and agreeing how
assistants may be delegated to.

**Return.** Every binding rule has an owner and an authority record.
Decisions an assistant made stay marked as its own until a human reads them.
Disagreement freezes the rule instead of letting it drift.

**Does not give.** Good rules. Governance protects the canon; it does not
write it.

## Level 3: Enforced architecture

**What it is.** The codebase is organised by meaning, and the build fails when
that organisation breaks.

- Hosts, Features, Foundations and Core, with dependencies pointing one way
  ([Pillars](Architecture.md#pillars), [Contracts and connectors](Architecture.md#contracts-and-connectors)).
- The placement test, applied when files are added or moved
  ([Placement](Architecture.md#placement)).
- A README in every component that answers five questions
  ([Feature README](Architecture.md#feature-readme)).
- Promotion only on a second real consumer ([Promotion](Architecture.md#promotion)).
- Conformance tests in the team's stack. In .NET:
  - one project per pillar;
  - [NetArchTest](https://github.com/BenMorris/NetArchTest) rules;
  - a README check.

  See [Reference/Billing](../Reference/Billing/README.md). Java teams have
  ArchUnit, and TypeScript teams have dependency-cruiser.

**What to copy.** Billing's project layout, `Directory.Build.props` (proof
beside its owner, compiled only by the test project), and
`Proofs/Architecture/`.

**Cost.** Weeks on an existing codebase, done boundary by boundary, never as a
bulk move. It costs little in a new one.

**Return.** Architecture erosion fails the build instead of surviving review,
including erosion introduced by an assistant in a large change.

**Does not give.** A correct domain model. The tests hold the shape; people
choose it.

## Level 4: Assisted review

**What it is.** AI contributions are checked by process, not only by the
human who asked for them.

- The [nomad-method](https://github.com/RikhoDev/nomad-method) plugin for
  Claude Code:
  - the working discipline at the start of every session;
  - a commit that restates canon is stopped once;
  - changes go to an isolated reviewer that never sees the author's
    reasoning.
- Periodic cold audits by a reviewer with no stake in the work.

**What to copy.** Install the plugin and list the canon in
`.nomad-method/canon`.

**Cost.** Minutes to install, plus a review round on each canon change.

**Return.** In this repository, every isolated review found defects the author
had missed ([canon Trail](_Trails/Canon.Trail.20261021.md)).

**Does not give.** Independence from AI. The reviewer is an AI too; the human
still has to know when to contradict both.
