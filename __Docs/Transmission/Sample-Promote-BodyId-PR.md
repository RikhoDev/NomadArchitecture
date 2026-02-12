# Sample PR: Propose Promotion of `BodyId` to `Core/` (Example PR Body)

Title: [Promote] BodyId → Core (example)

Description
- Summary: (Example only) Move `BodyId` into `Core/Contracts/` to unify identity semantics across Physics and Hosts.
- Chronicle (example): `__Docs/_Chronicles/20260212-Promote-BodyId-Example.md`

Consumers (example):
- `src/Features/PhysicsVNext/` — physics tests/usage
- `src/Hosts/PhysicsVNextDebugHost/` — playback rendering / debug traces

Tests included
- `tests/Core.Contracts.Tests/BodyIdTests.cs` — identity equality/serialization tests
- Migration tests: consumer adapters tests ensuring compatibility

Migration plan
- Add `Core/Contracts/BodyId.cs` and tests
- Add adapters in consumers referencing the chronicle
- Mark old `PhysicsVNext/BodyId.cs` as deprecated for N releases

Checklist (PR body)
- [ ] Chronicle linked
- [ ] Tests added and green
- [ ] Adapter code included
- [ ] Owners and reviewers tagged

Notes
- This is a worked example for reviewers and is not an actual proposal to execute the move. Real promotions must follow the playbook `__Docs/Transmission/PromotionToCore.md` and include the required evidence.
