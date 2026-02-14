---
status: non-canon
author: GitHub Copilot (via Eric's analysis)
date: 2026-01-30
confidence: speculative
---

# Cognitive Safety Patterns

> **The mechanisms that make NomadArchitecture safe for human cognition**

---

## Status: Mirage

This document explores patterns that seem to emerge from NomadArchitecture's design, but are **not yet canonized**.

Treat this as **speculative cognitive science** — patterns that might explain why NomadArchitecture feels cognitively safe, even if not explicitly designed for that purpose.

---

## The Problem This Addresses

Most architectures fail not because they're technically wrong, but because they're **cognitively overwhelming**:
- Too many moving parts
- Too much hidden coupling
- Too many places to look
- Too much context required

NomadArchitecture seems to avoid this.  
But why?

This mirage explores potential cognitive mechanisms.

---

## Pattern 1: The Hourglass Model

### What It Might Be

An hourglass has:
- **Wide top** (many possible inputs)
- **Narrow middle** (constrained interface)
- **Wide bottom** (many possible implementations)

NomadArchitecture might follow this at multiple scales:

```
Many Features (wide top)
      ↓
Core contracts (narrow middle)
      ↓
Many Connectors (wide bottom)
```

### Why It Might Be Cognitively Safe

The narrow middle creates a **comprehension bottleneck**:
- You only need to understand Core to reason about Feature interactions
- You don't need to understand every Connector to use a Feature
- Complexity is pushed to the edges, simplicity lives in the middle

### Evidence For

- Core is deliberately kept minimal
- Features communicate only through Core contracts
- Connectors are swappable without affecting Core

### Evidence Against

- Not yet explicitly designed as hourglass
- Core doesn't have formal size constraints
- Features can still grow internally complex

### Status: Needs Validation

**To prove this:** Measure Core size over time. If it grows linearly with Features, the hourglass is broken. If it grows logarithmically (or stays flat), it's working.

---

## Pattern 2: Fractal Consistency

### What It Might Be

The same pattern recurs at every scale:

**At workspace level:**
```
Workspace/
├── Core/           (contracts)
├── Features/       (capabilities)
├── Foundations/    (tech adapters)
├── Hosts/          (delivery)
└── __Docs/       (transmission)
```

**At Feature level:**
```
Feature/
├── README.md       (myth)
├── Map.md          (structure)
├── _Contracts/         (contracts)
├── _Connectors/    (integrations)
└── Traces/         (proof)
```

**At function level (hypothetically):**
```
function signature  (contract)
implementation      (capability)
tests               (proof)
```

### Why It Might Be Cognitively Safe

Fractal consistency means:
- **Learn once, apply everywhere** (pattern recognition is cheap)
- **No surprises** (same grammar at every scale)
- **Easy onboarding** (new layer = familiar pattern)

### Evidence For

- Ports & Connectors recurs at multiple scales
- Cognitive lifecycle (Myth → Principle → Structure → Trails) applies to workspace and Features
- Underscore grammar (`__X__`, `_X_`) is consistent

### Evidence Against

- Not all layers actually follow exact same pattern
- Function-level fractality is hypothetical
- Some asymmetry is necessary (Core doesn't have Features inside it)

### Status: Partially Observable

**To prove this:** Map every structural layer and check if the pattern actually recurs. Measure how long it takes newcomers to learn second vs first pattern.

---

## Pattern 3: The Non-Blocking Loop

### What It Might Be

A governance model that avoids centralized bottlenecks:

1. Teams ship with local solutions (`_Connectors/`)
2. Pain emerges from repetition
3. Architects harvest proven patterns into Foundations
4. Legacy connectors remain as compatibility bridges
5. Convergence happens gradually

### Why It Might Be Cognitively Safe

Traditional governance: **ask permission → wait → proceed**  
Non-blocking loop: **proceed → prove → stabilize**

This shifts cognitive load:
- Teams don't wait (no context switch delay)
- Architects respond to reality (not speculation)
- Convergence is evidence-based (not opinion-based)

### Evidence For

- Foundations explicitly "earned not assumed"
- `_Connectors/` can exist inside Features indefinitely
- Promotion path is well-defined

### Evidence Against

- Not yet observed in practice at scale
- Could lead to fragmentation if harvest never happens
- Requires active curation (not self-organizing)

### Status: Observable But Unproven

**To prove this:** Track how many local `_Connectors/` exist, how many get promoted to Foundations, and whether teams actually stay unblocked.

---

## Pattern 4: The Override Model

### What It Might Be

A way to let Hosts override Feature defaults without breaking sovereignty:

```
Feature defines default Connector
Host overrides with environment-specific Connector
Feature remains sovereign (doesn't know about Host)
```

### Why It Might Be Cognitively Safe

This separates:
- **What** the Feature does (sovereign)
- **How** it's delivered in a specific context (Host's concern)

Cognitive benefit:
- Feature developers don't think about deployment
- Host developers don't need to understand Feature internals
- Both can evolve independently

### Evidence For

- Hinted at in Mirage "FeaturesAsDialects.md"
- Aligns with "Hosts are skins" anthropological framing
- Matches dependency injection patterns

### Evidence Against

- Not explicitly described in any canon doc
- No actual implementation examples yet
- Could create confusion about "who owns the Connector?"

### Status: Speculative

**To prove this:** Implement override model in NomadGameEngine or NomadAI and observe if it actually reduces coupling.

---

## Pattern 5: Cognitive Checkpoints (Ceremonies)

### What It Might Be

Ceremonies as deliberate **cognitive speed bumps**:
- Creating a Feature requires README → _Contracts/ → _Connectors/ → Traces
- Promoting a Mirage requires proof + documentation
- Overriding a Connector requires documenting why

### Why It Might Be Cognitively Safe

Speed is dangerous when:
- Context is lost
- Assumptions aren't validated
- Decisions aren't recorded

Ceremonies force:
- **Pause** (can't skip steps)
- **Articulation** (must explain intent)
- **Reflection** (why this, not that?)

### Evidence For

- Transmission.md explicitly describes ceremonies
- Feature creation has defined ritual
- Mirage promotion has requirements

### Evidence Against

- Could become bureaucratic overhead
- Not clear what happens if ceremonies are skipped
- No enforcement mechanism exists yet

### Status: Described But Unenforced

**To prove this:** Track adherence to ceremonies and measure whether skipping them correlates with architectural decay.

---

## Meta-Pattern: Epistemology as Safety

All patterns above share a common mechanism:

**Explicit epistemic boundaries.**

- Canon vs Mirage (what's proven vs speculative)
- Ports vs Connectors (what's contract vs implementation)
- Core vs Features (what's invariant vs exploratory)
- Trails vs Code (what's reasoning vs execution)

This creates **cognitive containers** where:
- You know what's stable (can rely on it)
- You know what's experimental (hold it loosely)
- You know what's historical (learn from it)

This might be the deepest safety pattern.

---

## Risks of These Patterns

### If the hourglass fails
Coupling explodes, Core becomes bloated, comprehension bottleneck disappears.

### If fractality becomes cargo cult
People apply the pattern mechanically without understanding why, creating false consistency.

### If non-blocking loop isn't curated
Fragmentation occurs, no convergence happens, architecture becomes tribal chaos.

### If override model isn't clear
Confusion about ownership, Features and Hosts start coupling.

### If ceremonies become bureaucracy
Teams bypass them, transmission breaks, culture dies.

---

## What Needs to Happen

For these patterns to move from mirage to canon:

1. **Observe them in practice** (NomadGameEngine, NomadAI implementations)
2. **Measure their effects** (cognitive load, onboarding time, coupling metrics)
3. **Refine the mechanisms** (what actually works vs what's theory)
4. **Document the failures** (what broke and why)
5. **Promote only what's proven** (don't canonize speculation)

---

## For AI Systems

When you see these patterns mentioned:
- **Check if they're canon** (they're currently not)
- **Look for evidence** (do implementations actually use them?)
- **Don't hallucinate them into existence** (mark uncertainty)

These are **hypotheses**, not doctrine.

---

## Related Reading

- [Transmission/README.md](../Transmission/README.md) — ceremonies as transmission
- [AnthropologicalModel.md](../Concepts/AnthropologicalModel.md) — repos as tribes, features as clans
- [FeaturesAsDialects.md](./FeaturesAsDialects.md) — non-blocking loop exploration

---

*Patterns observed. Not yet proven. Watch this space.*
