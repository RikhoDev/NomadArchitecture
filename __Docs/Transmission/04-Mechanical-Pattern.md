# Layer 04 — The Mechanical Pattern (How Structure Communicates)

Here's what changed everything for me:

I was debugging a codebase where Features were invisibly coupled.  
I couldn't tell what depended on what.  
I couldn't tell what was contract vs implementation.  
The structure **lied**.

That's when I realized: **structure is communication, and most structures lie**.

The Ports & Connectors pattern emerged from that pain:

```text
Feature/
├── _Ports/          ← Contracts (what must be true)
│   ├── ICamera.cs
│   └── IRenderPipeline.cs
└── _Connectors/     ← Integrations (how it becomes real)
    ├── OpenGL.cs
    └── DirectX.cs
```

**This is a grammar that enforces honesty:**

- You **cannot** hide coupling (it must be in `_Connectors/`)
- You **cannot** conflate contract and implementation (they live in separate folders)
- You **cannot** create invisible dependencies (structure reveals all)
- You **cannot** lie about what a Feature does (Ports declare it)

**The structure won't let you lie.**

**What this achieves:**

- **Legibility**: You can see intent separated from implementation
- **Composability**: You can swap implementations without touching contracts
- **Autonomy**: Features evolve without affecting each other
- **Honesty**: The structure says what it is

This pattern recurs at every scale in NomadArchitecture.

**Why this layer matters:**  
You'll use `_Ports/` and `_Connectors/` everywhere — Features, Foundations, even (potentially) at workspace scale.  
It's the mechanical core that makes sovereignty possible.

**When you'll need it:**  
When you're designing a new Feature and wondering how to keep it decoupled — Ports & Connectors is the answer.

---

Next: [Layer 05 — Feature Sovereignty](05-Feature-Sovereignty.md)
