# Translation: Metaphors → Practical Rules

This short guide maps NomadArchitecture metaphors (Shaman, Mirages, Diplomats, Trails) to actionable rules and governance to help teams adopt the philosophy without confusion.

## Shaman → Steward of Continuity
- Practical rule: Rotating role. Keep a short checklist for repository health (e.g., docs generator, housekeeping, promotion decisions).
- When to act: after evidence in `Traces.md` accumulated or when system language drifts.

## Mirages → Exploration Documents
- Practical rule: Use Mirage docs for thought experiments and proposals; mark them clearly as "mirage" and do not treat them as canon until they are validated by trails.

## Diplomats → Connectors / Host Adapters
- Practical rule: A Diplomat lives in `_Connectors/terrain/` and is responsible for translating a Feature's Needs into host rituals.
- Keep Diplomats stateless and purely translational; avoid embedding domain logic.

## Trails → Traces & Evidence
- Practical rule: `Traces.md` is the evidence store. Before promoting code into `Core/` or `Foundations/`, ensure multiple traces show the pattern is real and stable.

## Ports → Contracts
- Practical rule: Ports are contract-only. They should never import host or foundation specifics and must be easy to mock.

## Promotion Guidance (quick)
- Connector → Foundation: when at least 3 Features reuse it and `Traces.md` shows stability.
- Port → Core: when concrete types and language are repeated and simplify cross-feature wiring.

---

Use this file as a quick on-ramp for collaborators who find the metaphors charming but want a crisp, practical checklist to follow. 🔧
