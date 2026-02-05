# Replay Strictness as a Policy Dial

## Thesis

Determinism is a property of the system + evidence.

**Replay strictness** is a property of *governance*.

The same captured evidence can be replayed once (smoke) or thousands of times (deep) to detect rare nondeterminism. The canon shape is: **replay is idempotent**. The policy dial is: **how hard do we try to falsify it**.

## Why it matters

- Many failures are *probabilistic in appearance* (race timing, floating-point edge cases, ordering ties, variable frame time).
- A single replay proving “it passed once” is useful, but weak.
- Repeating the same deterministic replay $N$ times is a pragmatic falsification attempt:
  - if hashes/semantic checks ever diverge, determinism is broken
  - if they never diverge, confidence rises (not because it’s “random”, but because nondeterminism often manifests intermittently)

## Where the dial lives (concerns)

**NomadArchitecture (canon)** defines:

- the *epistemology*: what counts as evidence
- the *contract*: pinned baselines are governance, not screenshots
- the *policy dimension*: strictness varies by team/stage/risk

**Implementation repos** define:

- the exact knobs (env vars, config, CLI flags)
- the harness mechanics and test loops
- the cost model and project-specific defaults

Canon should not leak mechanics; mechanics should not reinvent canon.

## Typical tiers

- **Smoke**: 1–10 replays (fast feedback)
- **Confidence**: 100 replays (catches “rare” nondeterminism)
- **Deep**: 1000+ replays (slow, ruthless)

The chosen tier should be explicit in pipeline governance (“what are we proving in this stage?”).

## Related

- Concept: [DataAsIdempotentTesting.md](DataAsIdempotentTesting.md)
