# Data as Idempotent Testing

## Thesis

Some failures cannot be *authored* into existence on demand; they must be *witnessed*.

**Data as idempotent testing** is the practice of turning that witness into durable evidence: captured traces become replayable fixtures, and replay becomes a CI-enforced boundary.

## What belongs where

NomadArchitecture should hold the *canon-level shape*:

- why this exists (epistemology: what counts as evidence)
- what must be true for it to work (determinism constraints)
- how it becomes governance (baseline as a contract)

Implementation repos should hold the *mechanics*:

- exact file formats
- capture tools/hosts
- replay harness code
- concrete scenario fixtures

## The minimum evidence

Capture only what changes state evolution:

- initial state (or seed + deterministic seeding)
- per-step $dt$ sequence
- per-step external inputs

Everything else is auxiliary (rendering, camera, windowing).

## Assertion layers (how evidence becomes governance)

Idempotent replay tests typically assert on multiple layers:

- **Signature**: broad change detector (hash/fingerprint)
- **Meaning**: a small semantic expectation (“the thing we care about”)
- **Safety**: invariants (finite values, bounded speeds)

The signature provides breadth; the semantic check provides intent.

Evidence is also a *policy dial*: teams can run the same replay once (smoke) or hundreds/thousands of times (deep) depending on cost and risk. The canon shape is “replay is idempotent”; the implementation chooses how strict to be.

## Failure modes (how evidence rots)

- Fixtures become too large and stop being curated.
- Determinism is assumed rather than enforced (flaky replay becomes noise).
- Baselines ossify behavior without acknowledging intent (hash-only, no meaning).

## Nomad trail

1. Mirage: exploration + uncertainty + evidence
2. Capture: minimum bundle recorded in an implementation repo
3. Promotion: replay test pins a baseline and enters CI
4. Canon: this Concept documents the stable shape

## Related

- Mirage: [../_Mirages/DataAsIdempotentTesting.md](../_Mirages/DataAsIdempotentTesting.md)
- Concept: [ReplayStrictnessAsPolicyDial.md](ReplayStrictnessAsPolicyDial.md)
