PR Template: Propose Promotion to `Core/`

Title: [Promote] <Type/Contract> → Core

Description:
- Short summary of the change and rationale
- Link to Chronicle (required): `__Docs/_Chronicles/<file>.md`
- Consumer links: list of PRs/commits using the type
- Compliance: list tests added/updated

Checklist (required):
- [ ] Chronicle attached and linked
- [ ] Tests included and green
- [ ] Migration/adapters included
- [ ] Owners have approved

Notes:
- Start in warn-only mode by running CI checks; only flip to hard enforcement once stable.

Example PR body snippets:

> This PR moves `BodyId` into `Core/` to avoid duplication across `PhysicsVNext` and debug hosts.
>
> Chronicle: `__Docs/_Chronicles/2026xx_Promote_BodyId.md`
>
> Tests: `tests/Core.Contracts.Tests/BodyIdTests.cs` (included)

---

Use this template as a starting point; include links to the Chronicle and all consumer references.