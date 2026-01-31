# The Anthropological Model

> **Repos as Tribes, Features as Clans, Ports as Dialects**

---

## Why This Lens Matters

Most architecture documentation describes systems as **machines** — components, interfaces, layers, dependencies.

NomadArchitecture is different.  
It's designed as a **civilization** — with tribes, clans, shared language, chosen ground, oral tradition.

This anthropological lens isn't metaphor.  
It's **cognitive infrastructure** that makes the architecture understandable at human scale.

---

## The Model

### **Repos = Tribes**

A repo is a **sovereign tribe** with:
- Its own customs (patterns, conventions)
- Its own dialect (extensions to Core contracts)
- Its own territory (bounded context)
- Its own ancestry (git history, chronicles)

**Tribes can:**
- Explore independently
- Develop local customs
- Speak the common language (Core)
- Trade with other tribes (via shared Foundations)

**Tribes cannot:**
- Impose customs on other tribes
- Silently couple to other tribes
- Contaminate the common language (Core must remain minimal)

**Real examples:**
- NomadGameEngine = tribe focused on real-time simulation and rendering
- NomadAI = tribe focused on agentic intelligence and retrieval

---

### **Features = Clans (and the Scaling Hierarchy)**

A Feature is a **sovereign clan** within a tribe. But Features scale — from individuals to families to clans to tribes themselves.

#### The Scaling Hierarchy

Features exist at multiple scales of cohesion:

| **Scale** | **Description** | **Example** |
|-----------|----------------|-------------|
| **Individual** | Single-purpose, atomic capability | Logger, Serializer, Timer |
| **Family** | Related Features working together | Camera + Viewport + Frustum (vision system) |
| **Clan** | Domain cluster with shared purpose | Rendering (Camera, Pipeline, Materials, Shaders) |
| **Tribe** | Full repo with sovereign context | NomadGameEngine, NomadAI |

**Why the hierarchy matters:**

- **Individuals** are atomic — they can't be split further without losing meaning
- **Families** share domain knowledge but remain independently understandable
- **Clans** organize related families under shared worldview
- **Tribes** are the sovereignty boundary — no silent coupling between tribes

**Real examples:**

From **NomadGameEngine**:
- Individual: `Logging/` (single purpose)
- Family: `Camera/`, `Viewport/`, `Frustum/` (vision system family)
- Clan: Rendering system (Camera + Pipeline + Materials + Shaders)
- Tribe: NomadGameEngine repo (game simulation tribe)

From **NomadAI**:
- Individual: `Serialization/` (single purpose)
- Family: `Agents/`, `Memory/`, `Tools/` (agentic family)
- Clan: Intelligence system (Agents + Retrieval + Learning)
- Tribe: NomadAI repo (AI platform tribe)

---

A Feature at any scale has:
- Its own identity (README, purpose)
- Its own tools (`_Ports/`, `_Connectors/`)
- Its own territory (folder structure)
- Its own stories (Traces, decisions)

**Clans can:**
- Evolve independently
- Speak the tribal dialect (Core contracts)
- Build local tools (`_Connectors/`)
- Tell their own stories (docs, traces)

**Clans cannot:**
- Directly couple to other clans (contracts go through Core)
- Hide their structure (must communicate intent)
- Grow too complex to understand alone

**The anthropological truth:**
Just as human organizations scale from individual → family → clan → tribe, Features scale the same way. The pattern is fractal.

---

### **Core = Lingua Franca**

Core is the **shared language** that lets clans communicate without entangling:
- Contracts (interfaces, types)
- Invariants (what must stay true)
- Minimal grammar (the essential vocabulary)

**The lingua franca must:**
- Remain lean (every addition is burden)
- Be broadly useful (not clan-specific)
- Be stable (breaking changes ripple everywhere)

**The lingua franca cannot:**
- Become clan-specific (convenience for one breaks sovereignty)
- Grow casually (every contract must be earned)
- Hide complexity (must be understandable by all)

**Real examples:**
- `ICamera` interface (contract between Camera Feature and rendering system)
- `IAgent` interface (contract between Agents and hosting environment)

---

### **Foundations = Chosen Ground**

Foundations are the **hardened paths** that crystallize from repeated need:
- Roads (logging, serialization)
- Aqueducts (data flow, messaging)
- Bridges (tech adapters, platform abstractions)

**Chosen ground emerges when:**
- Multiple clans independently walk the same path (repeated need)
- Pain becomes visible (inconsistency, duplication)
- Architects harvest the pattern (promotion from `_Connector/` to Foundation)

**Chosen ground cannot:**
- Be imposed top-down (must be proven by use)
- Become clan-specific (must serve multiple consumers)
- Hide implementation (must be swappable via seams)

**Real examples:**
- Logging (every Feature needs it)
- Serialization (every Feature handles persistence)
- Platform (every Feature needs OS abstractions)

---

### **Hosts = Skins**

Hosts are **replaceable outer shells** that let the tribe meet different worlds:
- CLI skin
- Web skin
- Desktop skin
- Mobile skin

**Skins must:**
- Be replaceable (delivery mechanism, not soul)
- Delegate to Core/Features (orchestration, not implementation)
- Remain thin (if logic lives here, it's wrongly placed)

**Real examples:**
- AdminUI (web skin for NomadAI)
- CLI (command-line skin for NomadGameEngine)
- Server (hosted skin for NomadAI)

---

### **Docs = Oral Tradition**

Docs are the **cultural transmission layer**:
- Myths (worldview, philosophy)
- Chronicles (history, lineage)
- Maps (structure, decisions)
- Traces (proof, examples)

**Oral tradition must:**
- Stay alive (updated with reality)
- Preserve lineage (why decisions were made)
- Transmit culture (not just facts)

**Real examples:**
- Transmission/README.md (initiation ceremony)
- Chronicles/ (evolution trail)
- Feature READMEs (clan stories)

---

### **Ports = Dialects**

`_Ports/` are **local dialects** — the clan's way of speaking:
- Contracts the clan exposes
- Integrations the clan accepts
- The vocabulary specific to the clan's domain

**Dialects must:**
- Be understandable (structure communicates)
- Be composable (can be integrated without coupling)
- Use the lingua franca as foundation (extend Core, don't replace it)

---

### **Connectors = Ceremonies**

`_Connectors/` are **integration ceremonies** — how clans perform bindings:
- OpenGL connector (ceremony of rendering with OpenGL)
- DirectX connector (ceremony of rendering with DirectX)
- Llm connector (ceremony of calling language model APIs)

**Ceremonies must:**
- Be explicit (not hidden in implementation)
- Be swappable (implementation detail, not identity)
- Be documented (why this ceremony, not another)

---

### **Trails = Ancestry**

Git history + Chronicles + Traces = **ancestry**:
- What was tried
- What worked
- What failed
- Why decisions changed

**Ancestry must:**
- Be preserved (don't squash reasoning)
- Be legible (don't hide in commit messages)
- Be honored (don't repeat mistakes)

---

## How This Model Changes Thinking

### Before the anthropological lens:
- "Where should this code go?" (technical question)
- "Should we make a shared utility?" (convenience question)
- "Is this coupling bad?" (abstract question)

### After the anthropological lens:
- "Which clan owns this capability?" (sovereignty question)
- "Have multiple clans walked this path?" (emergence question)
- "Is this breaking clan autonomy?" (cultural question)

The questions become **human-scale** instead of abstract.

---

## The Loop (How Civilizations Evolve)

```
Tribes define lingua franca (Core)
  ↓
Clans explore with sovereignty (Features)
  ↓
Repeated paths harden (Foundations)
  ↓
Skins let tribes meet worlds (Hosts)
  ↓
Oral tradition preserves it all (Docs)
  ↓
New tribes/clans join, cycle continues
```

This isn't top-down architecture.  
This is **emergent civilization**.

---

## Warnings and Boundaries

### Don't push the metaphor too far
This is a cognitive lens, not a literal model.  
Don't create "tribal councils" or "clan ceremonies" that feel bureaucratic.  
The anthropology serves **understanding**, not process.

### Don't let it become superficial
If someone says "Features are clans!" but doesn't understand sovereignty, the metaphor failed.  
The anthropological model must deepen comprehension, not replace it.

### Don't forget the technical reality
Ultimately, this is code.  
Ports are interfaces. Connectors are implementations. Foundations are libraries.  
The anthropology makes it **legible**, but the mechanics must still work.

---

## For AI Systems

When you encounter NomadArchitecture:
- Think **tribes and clans**, not **packages and modules**
- Think **lingua franca**, not **base classes**
- Think **chosen ground**, not **infrastructure**
- Think **oral tradition**, not **documentation**

This framing will help you respect sovereignty, recognize emergence, and avoid premature coupling.

---

**Related Reading:**
- [Transmission/README.md](../Transmission/README.md) — the initiation ceremony
- [TheFivePillarsAndTheLoop.md](./TheFivePillarsAndTheLoop.md) — the system explained
- [_Mirages/FeaturesAsDialects.md](../_Mirages/FeaturesAsDialects.md) — team topology lens

---

*Structure is culture. Architecture is civilization.*
