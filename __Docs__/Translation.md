---
status: non-canon
kind: guide
origin: ai-assisted
---

# Translation: Metaphors → Practical Rules

This short guide maps NomadArchitecture metaphors (Shaman, Mirages, Diplomats, Trails) to the rules that govern them, so teams can adopt the philosophy without confusion. It adds no rules; each entry links to the rule it applies.

## Shaman → Steward of Continuity
- Practical rule: the rotating human role that keeps continuity and authorizes what becomes canon. See [Evidence and Authority](Evidence-And-Authority.md#authority).
- When to act: when evidence has accumulated, when system language drifts, or when a proposal asks for a decision.

## Mirages → Exploration Documents
- Practical rule: use Mirage docs for thought experiments and proposals, and mark them `status: non-canon`. They are not canon until a human promotes them. See [Document kinds](README.md#document-kinds).

## Diplomats → Connectors
- Practical rule: a Diplomat is a connector, a thin relationship that wires a real seam between a Feature and something it does not own. It lives in the Feature's `_Connectors/`. See [Architecture: contracts and connectors](Architecture.md#contracts-and-connectors).

## Trails → Lineage
- Practical rule: a Trail records how a document or decision came to be, including the AI conversation behind it. See [Trails hold the conversation](README.md#trails-hold-the-conversation).
- Evidence that a pattern is real belongs with the proof of its owner, and is cited when promoting. See [Architecture: promotion](Architecture.md#promotion).

## Ports → Contracts
- Practical rule: a contract lives with the owner of its meaning, usually at the Feature root. The mandatory `_Ports` folder is [superseded](Concepts/PortsAndConnectors.md).

## Promotion Guidance (quick)
- See [Architecture: promotion](Architecture.md#promotion).

---

Use this file as a quick on-ramp for collaborators who find the metaphors charming but want a crisp, practical checklist to follow. 🔧
