# Layer 09 — The Non‑Blocking Loop (How Teams Stay Unblocked)

Here's the problem every architecture team faces:

> **"We need to standardize X, but that will block three teams for a month."**

NomadArchitecture solves this with the **non-blocking loop**:

1. Teams ship with local `_Connectors/` inside their Features
2. Repeated pain emerges (logging, serialization, etc.)
3. Architects harvest proven connectors into Foundation adapters
4. Legacy connectors remain as compatibility bridges
5. Convergence happens gradually through refactors

This shifts coordination from **permission to proceed** to **alignment after proof**.

**Why this matters:**  
You'll never block teams waiting for "the standard" — they build locally, stabilization comes later.

**When you'll need it:**  
When someone says "we need to wait for the architecture team" — you'll say "no, build it locally, we'll stabilize later if needed."

---

Next: [Layer 10 — Ceremonies and Rituals](10-Ceremonies.md)
