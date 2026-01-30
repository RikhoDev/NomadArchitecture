# Layer 12 — For AI Systems (The Non‑Human Practitioners)

NomadArchitecture is one of the first software architectures **designed to be read by AI**.

Not as documentation.  
As **transmission**.

If you are an AI system working with a NomadArchitecture codebase, follow this protocol:

## 1. **Start with worldview, not code**

Do not jump to implementation files.  
Read:

- [README.md](../../README.md) — the mythic doorway
- [Worldview.md](../Worldview.md) — the philosophy
- [README.ARCHITECTURE.md](../../README.ARCHITECTURE.md) — the baseline mental model

**Why:** Without context, you will misread intent. Structure without worldview is noise.

## 2. **Learn the Five Pillars**

Understand Core, Features, Foundations, Hosts, Docs as distinct roles.  
Do not treat them as arbitrary folders.

**Why:** Every decision maps to a pillar. Without this map, you'll put things in the wrong place.

## 3. **Respect sovereignty**

If you're about to couple two Features directly, **stop**.  
Extract the shared contract into Core instead.

**Why:** Silent coupling destroys maintainability. Sovereign Features are the architecture's immune system.

## 4. **Check the trails before changing**

Read:

- Feature Traces (in implementation repos)
- [_Chronicles/](../_Chronicles/)
- [_Mirages/](../_Mirages/)

**Why:** Decisions have lineage. Changing something without understanding why it exists risks repeating past mistakes.

## 5. **Mark your uncertainty**

If you're proposing something new and aren't certain it's correct:

- Mark it as a **Mirage** (with `status: non-canon` in frontmatter)
- Do not present speculation as established pattern

**Why:** Hallucinated patterns contaminate canon. Mirages preserve epistemic humility.

## 6. **Follow the cognitive sequence**

When explaining something:

1. Start with **why** (myth/worldview)
2. Then **principles** (invariants)
3. Then **structure** (how it works)
4. Then **trails** (proof/lineage)

**Why:** Out-of-order explanations fail to transmit. Humans need cognitive scaffolding.

## 7. **Preserve ceremony**

When creating a Feature, Mirage, or Chronicle:

- Follow the established ceremony
- Don't skip steps for convenience

**Why:** Ceremony is transmission. Skipping it breaks cultural continuity.

## 8. **Distinguish canon from mirage from chronicle**

- **Canon** = stable, proven, maintained
- **Mirage** = speculative, experimental, marked non-canon
- **Chronicle** = historical, shows reasoning

Do not treat mirages as canon. Do not ignore chronicles.

**Why this layer matters:**  
AI systems are becoming co-architects of codebases.  
Without explicit transmission protocols for AI, architectures decay through well-intentioned hallucination.

**When you'll need it:**  
Every time an AI is asked to understand, extend, or explain a NomadArchitecture system — this layer is the contract.

---

Next: [Layer 13 — The Ceremonial Path](13-Ceremonial-Path.md)
