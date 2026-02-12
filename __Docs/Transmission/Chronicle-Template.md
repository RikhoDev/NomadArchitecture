# Chronicle Template — Promotion Evidence

Use this template when you propose promoting a type/contract to `Core/`.

Title: Short descriptive heading (e.g., "Promote BodyId to Core — rationale and tests")

## Summary
- What is proposed (type/contract)
- Short rationale (why promotion helps)

## Evidence
- Consumers: list features/hosts using the type with links to commits/PRs
- Tests: list and link test artifacts that assert stable semantics
- Traces: links to relevant traces, benchmarks, or behavior tests

## Alternatives considered
- Why keep collocated? (pros/cons)
- Why adapters were insufficient

## Migration plan
- Outline steps to move consumers to `Core/` types
- Deprecation timeline (if applicable)
- Rollback criteria

## Reviewers / Owners
- Suggested reviewers (owners of features and Core maintainers)

## Decision log
- Record the final decision and any follow-ups

---

Attach this Chronicle to the promotion PR and link it from the PR description.