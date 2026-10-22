---
status: non-canon
kind: guide
origin: ai
---

# Translation: Metaphors → Practical Rules

## In industry terms

Closest equivalents, for readers who know the established vocabulary. They are
neighbours, not synonyms: each row says where NomadArchitecture differs.

| NomadArchitecture | Nearest industry term | Where it differs |
|---|---|---|
| Host | Composition root; application, service or entry point | It owns the purpose, the wiring and how refusals are shown, and nothing else. |
| Feature | Vertical slice; bounded capability | It is defined by its promise and its README answers, not by a layer. |
| Foundation | Infrastructure, adapters | It implements contracts the Features declare, never the reverse. |
| Core | Shared kernel | It is earned when language is spoken across pillars and no single owner remains, not designed in advance ([Promotion](Architecture.md#promotion)). |
| Contract | Port (hexagonal architecture) | It lives with the owner of its meaning, not in a ports folder. |
| Connector | Adapter between bounded contexts; anti-corruption layer | It is the only code that sees both sides, and it holds no policy. |
| Canon | Architecture standards; accepted ADRs | It is a short listed set, with declared authority on every change. |
| Canon owner, Shaman | Architecture board; CODEOWNERS | Authority is a file and a review, not a meeting. |
| Trail | Decision log; ADR context | It keeps the conversation, including the AI's, verbatim and apart from the rule. |
| Mirage | RFC; spike | It is explicitly non-binding, even when it contains working code. |
| `decided_by_assistant` | (none) | It marks what an AI decided under delegation until a human reads it. |
| Placement test | Cohesion; screaming architecture | It is one question, "whose meaning disappears if this does?", applied to every file. |
| Promotion | Rule of three; "extract when needed" | Two independent consumers are enough. |

## The metaphors

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
