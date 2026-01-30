# Layer 07 — Documentation as Architecture (Not Afterthought)

Most teams treat docs as:

- Something you write after
- Something that lags reality
- Something optional

In NomadArchitecture, **docs are part of the architecture itself**.

Every Feature has:

- **README** — why it exists (not just what)
- **Map** — how it works (structure, flow, decisions)
- **Traces** — proof it works (examples, lineage)

**A Feature without Trail is structurally incomplete.**

This is not optional. This is not "best practice."
This is a **structural invariant**:

- No README = no justification for existence
- No Map = no legibility of internals
- No Traces = no proof it actually works

**Incomplete Trail = incomplete Feature.**

If docs lie, the system lies.  
If docs are missing, the system is unreadable.  
If docs are out of sync, trust dies.

**Why this layer matters:**  
Onboarding speed, debugging clarity, and decision continuity all depend on docs being **true**.

**When you'll need it:**  
Every time you create a Feature, every time someone asks "why does this exist?" — docs are the answer.

---

Next: [Layer 08 — Canon vs Mirage vs Chronicle](08-Canon-Mirage-Chronicle.md)
