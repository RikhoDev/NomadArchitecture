# NomadArchitecture

> **A worldview can be a stronger foundation than a framework.**

NomadArchitecture is the culmination of 25 years across many aspects of software development — a long accumulation of patterns that kept screaming “nomad” before I could name it.

## The Origins

I kept returning to sliced architecture because it *felt* right. Then AI accelerated everything — powerful, but chaotic — and forced me to isolate features, reduce scope, and harden boundaries. I started calling those slices “nomad features.” The idea clicked.

As a cyberpunk fan, I first reached for the nomad culture in that fiction. But the fiction echoes real nomad cultures — and those cultures endured for centuries. So I went there: anthropology, history, and the survival practices that let societies transmit identity, sovereignty, and memory across generations.

## The Revelation

Software teams face the same pressures:

- **Teams rotate.** Knowledge evaporates. No one remembers why.
- **New people arrive.** They misread intent, copy patterns blindly, break what they don't understand.
- **Coupling hides.** Features entangle invisibly. Changes become dangerous. No one knows what depends on what.
- **Docs lie.** They lag reality, lose trust, get ignored. The "why" dies with the people who knew it.
- **The core bloats.** Every convenience adds weight. Every feature burdens the foundation.
- **No one owns anything.** Or everyone owns everything. Accountability dissolves. Coherence drifts.

NomadArchitecture is the result: a fractal, human-centered architecture that encodes **simplicity, intent, and transmission** into the structure of systems themselves — designed to preserve worldview, sovereignty, and lineage across teams, time, and generations.

Not as aesthetics. As survival practice.

**If this lands, it lands as a felt experience:**  
Clarity. Orientation. Momentum.

---

## The Core Triad

NomadArchitecture is built on three pillars that matter more than any framework:

- **Simplicity** — small core, clear contracts, honest structure  
- **Intent** — folders scream their purpose, features tell their stories  
- **Transmission** — knowledge survives rotation, culture outlasts people  

Everything else flows from these.

---

## The Loop (How It Circulates)

When this architecture works, a living loop keeps the system coherent:

**Core says what must be true.**  
**Features explore how.**  
**Foundations stabilize the how.**  
**Hosts deliver it.**  
**Docs keep it honest.**

Then the loop closes: experience feeds back into Core contracts, Foundations harden from proven patterns, Features innovate within growing clarity. Complexity grows without collapse.

---

## The Path Forward

Most architecture fails *before* it fails technically. It fails because people lose orientation.

This is where **order matters**:

1. **Myth** → opens the mind (you've just read it)
2. **Principle** → shapes the mind (next: The Core Triad + The Five Pillars)
3. **Structure** → guides the mind (then: Ports & Connectors, how structure speaks)
4. **Trails** → preserve the mind (finally: navigation to detailed proof and lineage)

If you read it out of order, it becomes "correct but lifeless."

---

## The Mythic Shock (Start Here)

Most architecture fails *before* it fails technically.  
It fails because people lose orientation:

- Why are we building this?
- What is allowed to change?
- Where does a new idea belong?
- How do we keep the core simple while complexity grows?
NomadArchitecture is a **cultural operating system** for codebases.

**Order matters:**

1. **Myth** → opens the mind
2. **Principle** → shapes the mind
3. **Structure** → guides the mind
4. **Trails** → preserve the mind

This sequence is the architecture's **immune system** against drift, entropy, and amnesia.  
If you read it out of order, it becomes “correct but lifeless.”

---

## How to Read This (Guided Path)

**Start here** if you want the full arc (recommended):

1. **Myth** (you are here): The wound, the origin, why this matters
   - [Worldview.md](./Worldview.md) — current snapshot of the vision
2. **Principle**: The core values and how the system circulates
   - [__Docs/Concepts/TheFivePillarsAndTheLoop.md](./__Docs/Concepts/TheFivePillarsAndTheLoop.md) — deep anatomy (read this next)
3. **Structure**: How ports & connectors create governance at every scale
   - [__Docs/Transmission/04-Mechanical-Pattern.md](./__Docs/Transmission/04-Mechanical-Pattern.md) — the pattern explained
4. **Trails**: Proof, lineage, and how to navigate the landscape
   - [__Docs/README.md](./__Docs/README.md) — the full map
   - [__Docs/_Chronicles/](./__Docs/_Chronicles/) — how we got here
   - [__Docs/_Mirages/](./__Docs/_Mirages/) — what we're exploring

**Or jump to what you need:**

- **Just want structure?** → [The Five Pillars](./README.md#the-five-pillars) (below)
- **Want proof it works?** → [Caravans/](./Caravans/) (repeatable journeys)
- **Curious about uncertainty?** → [__Docs/_Mirages/](./__Docs/_Mirages/)
- **Need the full context system?** → [__Docs/Transmission/README.md](./__Docs/Transmission/README.md)

---

## Principles (What Shapes Everything)

NomadArchitecture lives by three principles that matter more than any framework:

- **Simplicity** — small core, clear contracts, honest structure  
- **Intent** — folders scream their purpose, features tell their stories  
- **Transmission** — knowledge survives rotation, culture outlasts people  

Everything else flows from these.

---

## Structure (How It Manifests)

In a full Nomad implementation (game engine, AI platform, web host), the Loop takes shape as Five Pillars:

---

## The Five Pillars

In a full Nomad implementation repo (game engine, AI platform, web host), you’ll often see five parts:

| Folder | Meaning |
| --- | --- |
| **Core/** | Rules/contracts (the DNA). |
| **Features/** | Capabilities (sovereign modules). |
| **Foundations/** | Shared tools (kept lean). |
| **Hosts/** | Delivery skins (API/CLI/UI/jobs). |
| **__Docs/** | The “why” and the maps; part of the architecture. |

This particular repo focuses on **__Docs/**, chronicles, mirages.

---

## The Ordering Prefix (Explorer Clarity)

Nomad uses simple prefixes to control alphabetical order in the IDE explorer:

- `__Name/` → always on top (anchor folders you want visible)
- `_Name/` → next (secondary-but-important items)
- `Name/` → the main contents of the repo
- `zzzName/` → intentionally pushed down the list

This is not grammar. It’s a visibility practice — so the most important folders stay in view.

---

## Ports & Connectors (The Fractal Core) — a living pair 🪝

Ports and Connectors are not mere folder names; they are a paired discipline that keeps a Feature sovereign and discoverable.

- **_Contracts/** — *living contracts*: interfaces, DTOs, configuration and canonical state types that define what a Feature is and offers. Ports are the feature's public place to live and must include doc comments that state stability and intended consumers.
- **_Connectors/** — *host-facing adapters*: minimal, documented shims, DI helpers, and implementations that connect Ports to runtime infrastructure. Keep heavy logic internal to the feature; connectors are thin, intentional surfaces for hosts.

Principles we follow:

- **Pairing** — every public Port should have a Connector (or an explicitly whitelisted justification). Ports without connectors leak intent: infra or UI will creep into business code.
- **Connectors as gates** — Connectors may also act as *controlled plugouts* to grant scoped access to internal APIs. Access must be earned: document the rationale, name an owner, include tests, and add a whitelist entry or formal approval for such connectors.
- **Minimal surface** — expose only what you intend to be stable and consumed.
- **Discoverability** — public APIs must "scream" intent through placement, naming, and doc comments.

Practical rules & exceptions:

- **Allowed exceptions** must be whitelisted and justified (examples: cross-feature domain types promoted to Core, DTOs used by serializers, test helpers, examples/archived code). We keep exceptions explicit in `.feature-public-whitelist.json` with a short reason and approver.
- **DI / bootstrap helpers** belong in `_Connectors/` (e.g., `IServiceCollection` extension methods) so hosts can opt-in explicitly.

Migration recipe (safe path):

1. Add a minimal interface or contract to `_Contracts/` describing only what consumers need.
2. Make the implementation `internal` (or move it into the feature's internals) and implement the interface.
3. Add a `_Connectors/` shim for DI convenience / host glue and document its intent.
4. Add unit tests that exercise behavior through the Port contract and update the whitelist only if a genuine exception is necessary.

Examples & outcomes:

- A Feature declares `IThing` (Port). The host provides `ThingConnector` (Connector) and registers it during bootstrap. Tests exercise `IThing` with fakes, and the implementation remains free to change.
- Families (Feature groups) follow the same pattern: a Family's `_Contracts/` are the public contract for its children; its `_Connectors/` manage relationships between children.

Enforcement (how we make this practical):

- **Analyzer + test**: we plan a Roslyn analyzer and a reflective test that flag public types declared under `src/Features/**` that are outside `_Contracts/`/`_Connectors/` unless whitelisted.
- **PR checklist**: adding a public type requires doc comments, a connector skeleton or whitelist entry, and tests that validate usage through Ports.

This pairing is not pedantry — it keeps the repo honest, migratable, and easy to teach. Ports are where Features live; Connectors are how the world plugs in.

---

## Caravans (Repeatable Journeys)

Caravans are named, repeatable journeys through the architecture — a way to keep learning, onboarding, and verification grounded.

- What caravans are: [Caravans/README.md](./Caravans/README.md)
- Example manifest: [Caravans/gameplay.yaml](./Caravans/gameplay.yaml)

---

## A Note on AI Generation

This repo is **AI-assisted**.

- The ideas are human-driven; drafts are often AI-produced.
- Some documents are intentionally speculative (mirages).
- If you need “only hand-crafted truth,” treat this as an experiment — not a guarantee.

NomadArchitecture’s stance is simple: AI can accelerate drafts, but **trails and reality checks** must keep us honest.

---

## How to Contribute (Without Killing the Spark)

If you contribute, prefer changes that preserve the order and the honesty:

- Put speculative ideas in `__Docs/_Mirages/` and label them as non-canon.
- When something becomes real, move it into the appropriate canonical area and leave a trail in `__Docs/_Chronicles/`.
- Don’t “decorate” structure — structure is a promise. If you add folders, make them communicate.

---

## Closing

NomadArchitecture is not finished. It may never be.

But if it works, you will feel it:

- the repo teaches you what it is
- features explain themselves
- change leaves a trail
- complexity grows without collapse

If you’re curious, start at [__Docs/Worldview.md](./__Docs/Worldview.md).
If you want the full map, begin at [__Docs/README.md](./__Docs/README.md).
