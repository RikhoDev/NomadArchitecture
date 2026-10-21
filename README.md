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
Every Nomad project grows around five parts: **Hosts** (why), **Features** (what), **Foundations** (how), **Core** (the common language) and **__Docs__** (memory).  
Their essence is in the [Worldview](./Worldview.md#canonical-skeleton); their rules are in [Architecture](./__Docs__/Architecture.md#pillars).

---

## 📖 Example (Tiny Feature)
A Feature is more than just code—it carries its own story and its own proof. The [Greeting example](./examples/Greeting/README.md) runs:

```
examples/Greeting/
 ├── Hosts/Cli/greet.ps1                       # why: greet someone from a terminal
 └── Features/Greeting/
      ├── Greeting.ps1                         # what: the greeting promise
      ├── README.md                            # promise, residents, relationships, proof, status
      └── _Tests/Greeting.Tests.ps1            # proof it works
```

```
pwsh examples/Greeting/Hosts/Cli/greet.ps1 -Name Alice
Hello, Alice!
```

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
4. Run `pwsh Hosts/DocReader/reader.ps1` for a tour, then `canon`, `explain <path>` and `trail <path>`. The [DocReader](./Hosts/DocReader/README.md) is a Host built inside this repository by its own rules.
5. Run `pwsh Scripts/Test-Repository.ps1` to see the repository check its own claims.

---

## ✨ Closing Thought
NomadArchitecture is not a finished framework.  
It’s a journey—an attempt to find the simplest rules that let complex systems stay alive.  

If you’re curious, join in. If you’re skeptical, challenge it. Either way, the conversation helps keep the fire burning. 🔥  
