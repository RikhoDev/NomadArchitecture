# NomadArchitecture

**NomadArchitecture is an experiment in how we might structure code so it stays simple at its core, yet has room to grow in complexity without collapsing under its own weight.**  
It’s a work in progress—an attempt to encode not just technical rules, but also the worldview and continuity that help projects survive change.

---

## ⚠️ A Note on AI Generation
Most of what you’ll find here is **AI‑assisted and AI‑generated**, guided by careful prompt engineering and human curation.  
- The ideas are mine, but the words and drafts often come through AI.  
- I review, refine, and sometimes rewrite, but I don’t pretend this is purely “hand‑crafted.”  
- If that makes you uncomfortable, I understand if you’d rather not proceed.  
- If you’re curious, I invite you to explore with the awareness that this is both a **personal journey** and an **AI experiment**.

---

## 🌱 What This Project Aims At
Software architectures often struggle with:
- Growing complexity over time.  
- Knowledge loss when people leave.  
- Documentation that lags behind reality.  

**NomadArchitecture doesn’t claim to have solved these problems.**  
It’s an ongoing exploration of how we *might* address them by treating codebases as living systems:
- **Features** carry the system's meaning, each with its own story.  
- A small **core** of shared language grows only from what proves common.  
- **Docs** are part of the structure, not an afterthought.  
- **Hosts** (API, CLI, UI, jobs) compose Features into something runnable—they carry the purpose, and they can be replaced.  

---

## 🏗️ The Five Pillars
Every Nomad project is organized around five simple parts:

| Folder        | Purpose |
|---------------|---------|
| **Hosts/**    | WHY — compose Features into runnable delivery (API, CLI, jobs, UI). |
| **Features/** | WHAT — sovereign promises, each with its own story. |
| **Foundations/** | HOW — neutral mechanism that implements contracts. |
| **Core/**     | COMMON — shared language, earned through real use. |
| **__Docs__/** | Memory — the canon, plus the trails, mirages and chronicles behind it. |

The rules are in [__Docs__/Architecture.md](./__Docs__/Architecture.md).

---

## 📖 Example (Tiny Feature)
A Feature is more than just code—it carries its own context:

```
Features/
 └── Greeting/
      ├── GreetingService.cs   # the code
      ├── README.md            # why this feature exists
      ├── Map.md               # how it works
      └── Traces.md            # examples of it running
```

This way, anyone (human or AI) can see:
- **What it does**  
- **Why it exists**  
- **How it works**  
- **Proof it works**

---

## 🔑 Guiding Ideas
- **Keep the Core small** → it holds only language that real use has made common.  
- **Every Feature tells its own story** → no mysteries.  
- **Docs are part of the architecture** → not optional.  
- **Hosts are replaceable** → they carry the purpose; the meaning lives in Features.  

---

## 🧠 Why Explore This
The hope is that NomadArchitecture can:
- Make onboarding easier for new developers.  
- Give AI tools clearer structures to work with.  
- Help projects carry their intent forward, even as teams change.  

But this is still early work. These ideas are being tested, refined, and sometimes re‑thought. Feedback, experiments, and challenges are welcome.

---

## 🏁 How to Explore
1. Clone this repo.  
2. Read [Worldview.md](./Worldview.md) for the philosophy.  
3. Read [__Docs__/README.md](./__Docs__/README.md) for how the documentation is organised and what is canon.  
4. Explore `Features/` to see the folder conventions.  
5. Look at [examples/MinimalFeature](./examples/MinimalFeature/) for a minimal Feature connector. There is no runnable host example yet.

---

## ✨ Closing Thought
NomadArchitecture is not a finished framework.  
It’s a journey—an attempt to find the simplest rules that let complex systems stay alive.  

If you’re curious, join in. If you’re skeptical, challenge it. Either way, the conversation helps keep the fire burning. 🔥  
