# Chronicle — Example: Promote BodyId to Core (Worked Example)

> Status: example / educational — this file demonstrates the artifacts and reasoning expected when proposing a promotion. It is NOT an actual proposal to promote `BodyId` at this time.

## Summary
- Proposed (example): Promote `BodyId` (an identity type currently collocated in `src/Features/PhysicsVNext/`) to `Core/`.
- Rationale (example): Multiple independent consumers (PhysicsVNext, Diagnostics, Hosts) require consistent identity semantics for traces, snapshots, and recording. Promotion would centralize identity semantics and avoid accidental duplication.

## Evidence (example)
- Consumers (example links):
  - `src/Features/PhysicsVNext/` — uses `BodyId` widely in physics artifacts and tests.
  - `src/Hosts/PhysicsVNextDebugHost/` — debug host references `BodyId` in playback and rendering.
- Tests (example):
  - `tests/PhysicsVNext.Behavior.Tests` references `BodyId` in numerous tests verifying invariant behavior.
- Traces (example):
  - Recorded test traces and snapshot hashes rely on stable body identity across replay runs.

## Alternatives considered (example)
- Keep collocated at feature root (current): simplest, keeps ownership local; duplicates possible but reversible.
- Create an adapter at host boundary: keeps collocation but requires repeated adapters and translation.

## Migration plan (example)
1. Create `Core/Contracts/BodyId.cs` with identical semantics + tests under `tests/Core.Contracts.Tests/`.
2. Add adapters in consumers that map local `BodyId` to `Core.BodyId` and vice versa. Run tests in warn-only mode.
3. Deprecate the collocated `BodyId` with clear deprecation notes and a 2-release timeline.
4. Once all consumers migrate and tests are green, remove the old collocated `BodyId` and update docs.

## Reviewers / Owners (example)
- Suggested reviewers: owners of PhysicsVNext, Hosts (PhysicsVNextDebugHost), Core maintainers.

## Decision log (example)
- Decision: (example) — Pending evidence & sign-off.
- Notes: This example is a template demonstrating the Chronicle requirements; it does not enact the promotion.

---

Attach this Chronicle to a PR when proposing a real promotion.
