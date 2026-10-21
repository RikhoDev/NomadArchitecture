---
status: non-canon
kind: trail
origin: ai-assisted
---

# Worldview Trail, 2026-10-21: distilling canon from NomadGameEngineV2

> **Context:** NomadArchitecture had not changed since January 2026, while
> NomadGameEngineV2 (NGE) had applied and revised the method for nine months.
> An analysis compared the two and found that NGE practice contradicted
> several NomadArchitecture rules. The human then chose the direction recorded
> below.
> **Author:** Eric (Shaman), assisted by Claude Code.

## Decisions taken by the human

Recorded from the session on 2026-10-21:

1. NomadArchitecture becomes a **small base canon**, holding only general rules
   distilled from project evidence, each citing its source.
2. `_Ports`, the three-tier fallback, and connector promotion to Foundations
   are **superseded, files kept**, each pointing to its replacement.
3. AI conversation text is **separated** from the documents it produced and
   kept verbatim in Trails.
4. Canon growth is governed by a **rule without numeric caps**: every addition
   names what it replaces or removes.

## What the analysis observed

- NGE has no `_Ports` folder. A dossier rejects it explicitly: "explicitly
  avoid `_Contracts`, mandatory `_Ports`, and `_Capabilities`; retain only
  `_Connectors` because relationship itself is meaningful"
  (NGE:`Engine/__Docs/Dossiers/2608-23-Terrain-Feature-Family-Architecture-Migration.md`).
- NGE Foundations implement Feature contracts: the Foundations project
  references the Features project
  (NGE:`Engine/Foundations/NomadGameEngineV2.Foundations.csproj`). There is no
  fallback tier: "The absence of wiring IS the noop"
  (NGE:`Engine/__Docs/Worldview.md` §7).
- NGE grows from Host pressure: seam, then Foundations, then Features
  (NGE:`README.md`, Promotion Flow). The 2025 emergence rhythm put Features
  before Foundations.
- NGE has no `Map.md` or `Traces.md` files; it uses a six-question folder
  README. This stays an open decision (see `__Docs__/README.md`).
- NGE carries roughly 1.3k Markdown files. It has rules against mislabelling
  documents, but no rule limiting how canon grows. That gap is why the
  growth rule exists here.

## What changed in Worldview.md

Compared with the previous version (commit `6851a98`):

- The canonical skeleton table moved to `__Docs__/Architecture.md` (one fact,
  one owner).
- "Supports inside Features" (`_Ports` → Core, `_Connectors` → Foundations) was
  removed. It is superseded by the contracts-and-connectors rules in
  Architecture.
- The emergence rhythm was revised to match observed practice (above).
- Principles were folded into Commitments, adding "evidence before
  generalisation" and "say what you know, at the strength you know it".
- "README, Map, Traces" became "why it exists, how it works, and the proof that
  it works", which leaves the file format to the open decision.
- References to `Tribe.md` and `Transmission.md` were removed: neither file
  ever existed in this repository.
- The Shaman is now defined as the human who authorizes canon, matching the
  authority rule.

## The conversation framing removed from the previous Worldview.md

Kept verbatim, as the Trail convention requires. The opening lines:

> # Worldview of NomadArchitecture (2025‑11)
>
> > **Prompt**: Very nice. Now build me, by analysing the current conversation versus https://github.com/RikhoDev/NomadArchitecture/blob/main/Worldview.md, the most accurate worldview to date.
> >
> > _Ai re-generated, unrevised November 2025_

The closing lines:

> ✅ This version integrates the repo’s current worldviewwith the refinements from our discussion: **Shaman role, supports clarified, Ports → Core, Connectors → Foundations, and the emergence rhythm.** It is the most accurate worldview to date.
>
> Would you like me to **prepare this as a commit‑style diff** so you can drop it directly into the repo?

The full previous text is in git history at commit `6851a98`.
