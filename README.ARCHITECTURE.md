# NomadArchitecture: The System

## The Mythic Foundation

NomadArchitecture is a **cultural operating system** — a set of boundaries and contracts that let complexity grow without collapse.

It starts with a shock: *What if the software could transmit intent, not just function?*

**The cognitive sequence that preserves this intent:**

1. **Myth** (the shock, the worldview)
2. **Principle** (the rules that follow from the worldview)
3. **Structure** (the artifacts and patterns that embody principles)
4. **Trails** (proof: examples, lineage, and lineage of change)

Read them out of order and you get correct but lifeless rules. Read them in order and the system self-transmits.

---

## The Five Pillars (Structural Framework)

Every NomadArchitecture implementation organizes around five pillars:

| Pillar | Purpose | Constraint |
|--------|---------|-----------|
| **Core/** | Rules and contracts (the invariants). | Must be minimal. Leverage over lines of code. |
| **Features/** | Sovereign capabilities. Each tells its own story. | Must not entangle with other features. |
| **Foundations/** | Technology adapters and hardened infrastructure. Chosen ground. | Infrastructure only, not domain logic. Multiple features must need it. Can be swapped via seams. |
| **Hosts/** | Delivery surfaces (API, CLI, UI, jobs, etc.). | Replaceable. The soul lives in Core + Features. |
| **__Docs/** | The "why," the maps, the trails. Part of the architecture itself. | Must stay synchronized with reality. |

**The shape of this matters.** It's not a hierarchy; it's a skeleton.

Core doesn't command Features. Core sets the contracts; Features innovate within them.
Hosts are skins; they don't define the system.
Docs aren't decoration; they're the transmission medium.

---

## The Mechanical Pattern: Ports & Connectors

One pattern recurs throughout implementation repos:

```
Feature/
├── _Contracts/          ← Contracts (what must be true)
│   ├── ICamera.cs
│   └── IRenderPipeline.cs
└── _Connectors/     ← Integrations (how it becomes real)
    ├── OpenGL.cs
    └── DirectX.cs
```

**What this achieves:**
- Legibility: intent and implementation are visually separated
- Composability: you can wire different implementations without touching the contract
- Autonomy: Features can evolve their internals without affecting others
- Honesty: the structure says what it is

**Why this pattern matters at every scale:**
At the feature level, _Contracts/ is the feature's core and _Connectors/ are its integrations.
At the workspace level (a living question — see mirages), the same pattern could scale: documentation contracts instead of code interfaces.

---

## Flexibility with Controlled Expansion

NomadArchitecture is built to grow. But growth without control is collapse.

**The control mechanisms:**

### 1. Structure Is Naming
The underscore grammar prevents silent sprawl:

- `__Name__/` → Pillars (canonical, binding, rarely change)
- `_Name_/` → Liminal (experimental, non-canon, watched closely)
- `Name/` → Emergent (grows by need, not by design)

Names are promises. If you add a folder, you're making a claim about what it is.

### 2. Sovereignty Principle
Features are sovereign domains. They can:
- Have their own _Contracts/ and _Connectors/
- Own their README (explain themselves)
- Own their Traces (proof of execution)

They cannot:
- Directly couple to other features (only through Core contracts)
- Hide their implementation (structure communicates)
- Become too complex to understand in isolation

### 3. Core as Constraint, Not Command
The Core is minimal by design. It sets the operating rules:
- What every feature must provide (dependency injection contract)
- What every host must understand (runtime contract)
- What constitutes a valid feature or host (structural contract)

Features innovate *within* these constraints, not against them.

### 4. Documentation as Part of the Architecture
Docs aren't written *about* the system; they *are* the system's transmission.

- Feature READMEs explain why the feature exists (not just what)
- Traces prove the feature works (not just assertions)
- Chronicles record why structure changed (not just the code diff)
- Mirages mark speculative experiments (honesty about uncertainty)

If docs lie, the system lies.

### 5. Foundations as Chosen Ground
Foundations are not "utilities that grew over time." They are **chosen ground** — hardened supports that let Features stay sovereign without reinventing the same mechanisms.

**The kinds of real project pain Foundations solve:**
- Every Feature invents its own logging/tracing style, so debugging cross‑feature behavior becomes guesswork.
- Each Feature picks a different serialization or storage strategy, and integration breaks in surprising ways.
- Teams fork threading/concurrency helpers and introduce subtle performance regressions.
- Observability is ad‑hoc, so ops can’t correlate a single request across systems.
- Security or tenancy policies are re‑implemented inconsistently, creating hidden risk.

Foundations address these without swallowing domain logic. They give Features stable, tech‑level seams so the work stays focused on the domain.

**Why Foundations complement Features (not replace them):**
- Features define *what* the system does; Foundations support *how* it stays reliable.
- Features stay sovereign because they depend on shared *mechanisms*, not shared *semantics*.
- Foundations reduce repetition and drift, letting Features converge on consistent behavior.

**Why it’s not called Infrastructure:**
Infrastructure implies a fixed basement — always there, always heavy. Foundations are **earned**, not assumed.
They harden only when stability is worth the cost, and they stay swappable through seams.

**Guardrails that keep the balance:**
- **Adapter layer**: Technology‑facing, not domain‑facing (LLM clients, storage, observability, serialization, threading)
- **Multiple consumers**: Only hardened when at least two features independently need it
- **Swappable by seams**: Always expose contracts (_Contracts) so implementations can change without reshaping features
- **Grown from _Connectors**: Promotion path is _Connector (inside Feature) → hardened Foundations (shared across Features)

This prevents Foundations from becoming a dumping ground while letting genuine shared supports crystallize.

---

## The Expansion Grammar

When you add something new, ask:

**Is this a new Pillar?**
→ Extremely rare. Validate hard. This changes what Core must orchestrate.

**Is this a new Feature?**
→ Give it _Contracts/, _Connectors/, README, and Traces.
→ Does it couple to other features? If yes, extract the shared contract into Core.

**Is this a new Host?**
→ It implements the Host contract defined in Core.
→ Add it to Hosts/ and document what makes this delivery surface distinct.

**Is this a new Foundation mechanism?**
→ Only if at least two features are independently discovering they need it.
→ Keep contracts minimal and tech-facing (logging, observability, serialization, memory, threading).
→ Domain logic belongs in Core or Features, not Foundations.
→ Always provide seams (_Contracts) so implementations can be swapped.
→ Move a _Connector to Foundations only when it's hardened and multiple features depend on it.

**Is this a new Concept or Chronicle or Mirage?**
→ Docs are free to expand. Mark clearly: canon, non-canon, or experimental.
→ Always answer: "What should a reader know that they don't now?"

---

## What Stays Stable (Boundaries)

NomadArchitecture commits to a few things:

1. **The Five Pillars structure** — Core, Features, Foundations, Hosts, Docs
2. **The Myth-Principle-Structure-Trails ordering** — the transmission sequence
3. **Sovereignty of Features** — no silent coupling, no hidden complexity
4. **Structure as Communication** — naming, folders, and layout are part of the message
5. **Trails as Evidence** — examples, lineage, and proof must be kept honest

Change anything else if the system asks for it.

---

## What's Intentionally Open (Flexibility)

1. **Core Content** — What the Core actually contains depends on the problem domain
2. **Feature Design** — How a feature organizes internally (as long as it's legible and sovereign)
3. **Host Implementation** — Different tech stacks can implement the Host contract
4. **Mechanisms in Foundations** — What shared tools actually get built
5. **Expansion at any scale** — New features, new hosts, new pillars (with extreme caution) can all emerge

---

## The Tension That Must Be Held

NomadArchitecture exists at the intersection of two forces:

**Seed vs. Doctrine**
- The seed invites emergence and organic growth
- Doctrine preserves invariants and prevents collapse

Both are necessary. The system lives in the tension.

**Design vs. Discovery**
- Some structure must be designed (Core, the Five Pillars)
- Some structure must emerge through need (new features, new patterns)

The expansion grammar helps you tell which is which.

**Autonomy vs. Coherence**
- Features must be able to grow independently (sovereignty)
- The system must remain legible and unified (structure communicates)

Ports & Connectors pattern makes this possible.

---

## For AI Systems Reading This

If you're being asked to extend or understand a NomadArchitecture codebase:

1. **Find the Core first.** This is the semantic center. Everything else builds from it.
2. **Understand the constraints in Core.** These are non-negotiable.
3. **Map the Features.** What is each Feature claiming to do? Are the claims honest?
4. **Check the Traces.** Do the examples prove the claims?
5. **Read the Docs together with code.** If they diverge, the system is lying about itself.
6. **Respect sovereignty.** If you're about to couple two Features, extract the shared contract into Core instead.
7. **When adding something, name it with intention.** Names are promises.
8. **Propose carefully.** If it would change the Five Pillars or the Myth-Principle-Structure-Trails ordering, it's not an extension—it's a redesign.

---

## For Humans Building With This

**Onboarding approach:**
1. Read the Worldview (why does this exist?)
2. Skim the Five Pillars (where are we building?)
3. Pick a Feature and understand it completely (how do Features work here?)
4. Try to extend something small (what does it feel like to work in this system?)
5. Walk the chronicles and mirages (what did we learn? what are we wondering about?)

**Contributing approach:**
1. **Preserve the shock.** If you remove the mythic element, you remove the transmission.
2. **Keep sovereignty visible.** If a Feature can't be understood alone, it's coupled.
3. **Make structure communicate.** Don't hide intent in implementation.
4. **Update trails.** Proof and lineage are as important as the code.
5. **Mark experiments.** If it's speculative, label it as mirage, not doctrine.

---

## The Question at the Edge

There is an open question: Does the Port/Connector pattern want to scale to the workspace level?

Could NomadArchitecture's own __Docs/_Contracts/ be the "Core" of a workspace, with multiple implementation repos (NomadGameEngine, NomadAI, etc.) each declaring what they fulfill?

This is not answered. It lives in [__Docs/_Mirages/ScaleThePattern.md](./__Docs/_Mirages/ScaleThePattern.md) as a living question.

If the workspace asks for it, the pattern will reveal itself. If it's forced, it will feel wrong. That's how you tell.

---

## The Bet

NomadArchitecture is betting that:

- **Structure is stronger than rules** (because structure self-transmits, rules don't)
- **Small cores are more coherent than large ones** (because leverage > lines of code)
- **Sovereignty scales** (because legible coupling beats hidden dependency)
- **Trails matter as much as code** (because maintenance is 90% of the journey)

If these bets are right, you'll feel it in the codebase: clarity, momentum, and the ability to onboard new people fast.

If these bets are wrong, the system will accumulate friction and collapse. That's useful too—you'll learn what actually matters.

---

## What This Document Is

This document is the **baseline mental model** for NomadArchitecture.

It's not a handbook (that lives in __Docs/_Chronicles/ and Traces).
It's not a specification (that emerges from Features).
It's the **common ground** that lets humans and AI work together on these systems with shared understanding.

If you're building in a NomadArchitecture codebase, this is the thought process. If you're extending it, this is the boundary you're respecting. If you're questioning it, this is what you're questioning.

Start here. Then go deeper.
