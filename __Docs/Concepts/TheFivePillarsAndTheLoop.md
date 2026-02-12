# The Five Pillars and the Loop

> **A transmission: How software codebases can hold together without collapsing.**

This is not a framework. It's a pattern that keeps showing up when systems stay coherent over time.

---

## The Loop

**Core says what must be true.**  
**Features explore how.**  
**Foundations stabilize the how.**  
**Hosts deliver it.**  
**Docs keep it honest.**

That's the loop. When it works, complexity grows without collapse.

---

## The Five Pillars (What They Are)

Each pillar **screams its purpose**. Structure is communication.

### Core/ — The Invariants

Core is the smallest set of rules that everything else depends on.

- What every Feature must provide (dependency injection, lifecycle contracts).
- What every Host must understand (runtime, orchestration).
- What constitutes valid structure (how Features and Hosts wire together).

**Core is not a command center.** It doesn't tell Features what to do. It sets the contracts; Features innovate within them.

**Core/ screams:** *"These are the rules. Everything builds on this."*

**Metaphor:** Core is the constitution. Features are the cities. The constitution doesn't govern daily life; it makes coexistence possible.

---

### Features/ — Sovereign Capabilities

Features are self-contained units of capability. Each one:
- Has its own `_Ports/` (contracts it defines).
- Has its own `_Connectors/` (how it integrates with the world).
- Tells its own story (README, Map, Traces).

**Features must not couple to each other.** If two Features need to talk, the shared contract goes into Core.

**Why sovereignty matters:**  
When a Feature can be understood in isolation, it can be changed, replaced, or debugged without touching the rest of the system.

**Features/ screams:** *"These are autonomous. Each stands alone."*

**Metaphor:** Features are city-states. Each has its own dialect, laws, and customs. They share a common language (Core), but they don't dictate to each other.

---

### Foundations/ — The Chosen Ground

Foundations are **not** "utilities that grew over time."  
They are **hardened technical adapters** — chosen ground that lets Features stay focused on domain logic.

**What Foundations solve:**
- Every Feature invents its own logging → debugging becomes guesswork.
- Every Feature picks a different serialization → integration breaks.
- Each Feature reimplements threading → subtle performance regressions.
- Observability is ad-hoc → ops can't correlate requests across systems.

**What Foundations are:**
- Technology-facing, not domain-facing (LLM clients, storage, observability, threading, serialization).
- Promoted from proven `_Connectors/` when multiple Features independently need the same thing.
- Swappable through seams (always expose contracts so implementations can change).

**Foundations/ screams:** *"This ground is proven. Build on it."*

**Metaphor:** Foundations are Roman roads. They don't tell you where to go, but they make every journey faster. Local cultures stay local; roads make trade possible.

**Why not "Infrastructure"?**  
Infrastructure implies a fixed basement — always there, always heavy.  
Foundations are **earned**, not assumed. They harden only when stability is worth the cost.

---

### Hosts/ — The Delivery Skins

Hosts are how the system meets the world:
- API (HTTP endpoints).
- CLI (command-line tools).
- UI (web, desktop, mobile).
- Jobs (background workers, schedulers).

**Hosts are replaceable.** The soul of the system lives in Core + Features. Hosts are just skins.

**Hosts/ screams:** *"These are replaceable. The soul lives elsewhere."*

**Metaphor:** Hosts are storefronts. The goods (Features) stay the same; the shopfront changes with the market.

---

### __Docs/ — The Transmission Medium

Docs are not decoration. They are **part of the architecture itself.**

- Feature READMEs explain **why** the feature exists (not just what).
- Traces prove the feature works (not just assertions).
- Chronicles record **why** structure changed (not just the code diff).
- Mirages mark speculative experiments (honesty about uncertainty).

**__Docs/ screams:** *"This is how we think. This is how we transmit."*

**If docs lie, the system lies.**

**Metaphor:** Docs are the oral tradition. Code is what happened; docs are why it happened and what it means.

---

## The Mechanical Pattern: Ports & Connectors

One pattern recurs at every scale:

```
Feature/
├── _Ports/          ← Contracts (what must be true)
│   ├── ICamera.cs
│   └── IRenderPipeline.cs
└── _Connectors/     ← Integrations (how it becomes real)
    ├── OpenGL.cs
    └── DirectX.cs
```

**What this achieves:**
- **Legibility:** Intent and implementation are visually separated.
- **Composability:** You can wire different implementations without touching the contract.
- **Autonomy:** Features can evolve their internals without affecting others.
- **Honesty:** The structure says what it is.

At the Feature level: `_Ports/` is the Feature's Core, `_Connectors/` are its integrations.  

**Collocation (practical rule):** Private types should live with their implementers; family-shared vocabulary stays at the feature root until it earns a phase home; boundary language belongs in `_Ports/` (or, when proven common, in `Core/`).

At the workspace level (an open question): Could the same pattern scale? Documentation contracts instead of code interfaces?

---

## The Historical Echo (Why This Feels Right)

This structure echoes how human cultures have always organized:

**Greek city-states:**  
Each polis had its dialect and customs (Features), but shared myths, philosophy, and civic concepts (Core) that made trade and debate possible.

**Roman roads + law:**  
Local practices varied (Features), but roads, citizenship rules, and legal frameworks (Foundations) created a common surface to build on.

**Modern standards:**  
HTTP, TCP/IP, JSON, OAuth (Foundations) are not "the product." They're the ground that lets diverse teams and products coexist.

**The pattern:**  
- **Core** = shared language, shared rules.
- **Features** = local culture, local dialects.
- **Foundations** = roads, standards, common infrastructure.
- **Hosts** = how the culture meets outsiders (ports, markets, interfaces).
- **Docs** = the stories, lineage, and memory.

---

## The Non-Blocking Loop (How It Avoids "Architecture Team Blocks Us")

1. **Teams ship with local `_Connectors/`** inside their Features.
2. **Repeated pain emerges** (logging, observability, serialization, threading, tenancy).
3. **Architects harvest proven connectors** into a Foundation adapter with minimal contracts.
4. **Legacy connectors remain** as compatibility artifacts until touched.
5. **Convergence happens gradually** through refactors, not a big-bang rewrite.

This shifts coordination from "permission to proceed" to "alignment after proof."

Teams keep moving. Architecture crystallizes from need, not from prediction.

---

## What Stays Stable (The Boundaries)

NomadArchitecture commits to a few things:

1. **The Five Pillars structure** — Core, Features, Foundations, Hosts, Docs.
2. **The Myth → Principle → Structure → Trails ordering** — the transmission sequence.
3. **Sovereignty of Features** — no silent coupling, no hidden complexity.
4. **Structure as Communication** — naming, folders, and layout are part of the message.
5. **Trails as Evidence** — examples, lineage, and proof must be kept honest.

Change anything else if the system asks for it.

---

## What's Intentionally Open (The Flexibility)

1. **Core Content** — What the Core actually contains depends on the problem domain.
2. **Feature Design** — How a feature organizes internally (as long as it's legible and sovereign).
3. **Host Implementation** — Different tech stacks can implement the Host contract.
4. **Mechanisms in Foundations** — What shared tools actually get built.
5. **Expansion at any scale** — New features, new hosts, new pillars (with extreme caution) can all emerge.

---

## The Tension That Must Be Held

NomadArchitecture exists at the intersection of two forces:

**Seed vs. Doctrine**  
- The seed invites emergence and organic growth.
- Doctrine preserves invariants and prevents collapse.

Both are necessary. The system lives in the tension.

**Design vs. Discovery**  
- Some structure must be designed (Core, the Five Pillars).
- Some structure must emerge through need (new features, new patterns).

**Autonomy vs. Coherence**  
- Features must be able to grow independently (sovereignty).
- The system must remain legible and unified (structure communicates).

The Ports & Connectors pattern makes this possible.

---

## The Bet

NomadArchitecture is betting that:

- **Structure is stronger than rules** (because structure self-transmits, rules don't).
- **Small cores are more coherent than large ones** (because leverage > lines of code).
- **Sovereignty scales** (because legible coupling beats hidden dependency).
- **Trails matter as much as code** (because maintenance is 90% of the journey).
- **Foundations are earned, not assumed** (because infrastructure chosen too early becomes a cage).

If these bets are right, you'll feel it in the codebase: clarity, momentum, and the ability to onboard new people fast.

If these bets are wrong, the system will accumulate friction and collapse. That's useful too — you'll learn what actually matters.

---

## For Humans Building With This

**Onboarding:**
1. Read the Worldview (why does this exist?).
2. Skim the Five Pillars (where are we building?).
3. Pick a Feature and understand it completely (how do Features work here?).
4. Try to extend something small (what does it feel like to work in this system?).
5. Walk the chronicles and mirages (what did we learn? what are we wondering about?).

**Contributing:**
1. **Preserve the shock.** If you remove the mythic element, you remove the transmission.
2. **Keep sovereignty visible.** If a Feature can't be understood alone, it's coupled.
3. **Make structure communicate.** Don't hide intent in implementation.
4. **Update trails.** Proof and lineage are as important as the code.
5. **Mark experiments.** If it's speculative, label it as mirage, not doctrine.

---

## The Question You're Probably Asking

**"Have I nailed software codebases with _Ports/, _Connectors/, and five pillars — one for invariants, one for story, one for capabilities, one for foundations, one for delivery?"**

Yes. The loop is complete:

- **Core** = what must be true.
- **Features** = how we explore.
- **Foundations** = how we stabilize.
- **Hosts** = how we deliver.
- **Docs** = how we remember.

When all five are present and the loop holds, the system can grow without collapsing.

---

*This is not a framework. It's a pattern that codebases discover when they survive long enough.*
