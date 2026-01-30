# Layer 06 — Foundations as Chosen Ground (Not Infrastructure)

Here's the trap I see teams fall into:

They create a "shared utilities" folder.  
It becomes a dumping ground.  
Features couple through "convenient helpers."  
The architecture collapses.

**Foundations are not utilities.**  
They are **chosen ground** — hardened when multiple Features independently prove they need the same technical adapter.

**Real pain Foundations solve:**

- Every Feature invents its own logging → debugging is guesswork
- Every Feature picks different serialization → integration breaks
- Each Feature forks threading helpers → performance regresses
- Observability is ad-hoc → ops can't correlate requests

**The promotion path:**  
`_Connector/` (inside Feature) → proven by repetition → hardened Foundation (shared across Features)

**Why it's not called "Infrastructure":**  
Infrastructure implies a fixed basement, always there, always heavy.  
Foundations are **earned**, not assumed.

**Read:**

- [_Mirages/FeaturesAsDialects.md](../_Mirages/FeaturesAsDialects.md) — the team topology lens

**Why this layer matters:**  
You'll resist premature abstraction and let Foundations crystallize from need.

**When you'll need it:**  
When someone proposes "let's build a shared X" — you'll ask "have at least two Features independently asked for it?"

---

Next: [Layer 07 — Documentation as Architecture](07-Documentation-as-Architecture.md)
