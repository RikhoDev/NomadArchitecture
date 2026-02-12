# Promotion to Core — Playbook

This document describes the process, evidence, and minimal checklist for promoting a type or contract from a Feature into `Core/`.

Purpose
- Prevent premature promotion and preserve coherent sovereignty.
- Make promotion deliberate, evidence-based, and reversible.

When to propose promotion
- Multiple (2+) independent consumers (features or hosts) use the type/contract with consistent semantics.
- There is a demonstrated duplication or cost of not sharing (integration friction, repeated translation adapters).
- Tests and traces assert stable behavior and invariants.

Promotion checklist (required)
1. Evidence: list the independent consumers and link to commits/PRs showing usage.
2. Chronicle: write a short Chronicle documenting reasoning, alternatives considered, and a migration plan. Use the `Chronicle-Template.md` for structure.
3. Tests: Unit + behavior tests that exercise the contract and its invariants from all consumers.
4. PR: Open a PR that:
   - Moves the type/contract to `Core/`.
   - Adds deprecation/adaptation code and adapters for existing consumers if needed.
   - Includes a migration and rollback plan.
   - References the Chronicle and test artifacts.
5. Review & Governance: Owners listed in the Chronicle must approve; reviewers must verify tests and migration plans.

PR checklist (what the PR must include)
- [ ] Link to Chronicle file with rationale
- [ ] Proof-of-use: links to consumer PRs or commits
- [ ] Tests added/updated to verify behavior across consumers
- [ ] Adapter code demonstrating how existing consumers will migrate
- [ ] Deprecation notes and timeline (if any)

Rolling back
- Keep the change small and reversible. If breakage occurs, revert the PR and re-open the Chronicle for further investigation.

Notes
- Promotion should be conservative. Duplicate small types are acceptable and reversible; premature Core growth is not.
- The goal is to make `Core/` earned and maintainable.

---

Refer to `PR-Template-Promote-Core.md` and `Chronicle-Template.md` for the artifacts to include when proposing promotion.