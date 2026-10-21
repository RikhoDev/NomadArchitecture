---
status: non-canon
kind: trail
origin: ai-assisted
---

# Worldview Trail, 2026-10-21: distilling canon from NomadGameEngineV2

> **Context:** NomadArchitecture had not changed since January 2026, while
> NomadGameEngineV2 (NGE) had applied and revised the method for nine months.
> An analysis compared the two and found that NGE practice contradicted
> several NomadArchitecture rules.
> **Author:** Eric (Shaman), assisted by Claude Code.

## Decisions and review loops

Recorded once, for the canon as a whole, in
[__Docs__/README.Trail.20261021.md](__Docs__/README.Trail.20261021.md),
with the human's words quoted verbatim.

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

- The voice, the structure (Principles, Canonical Skeleton, Emergence Rhythm,
  The Shaman, Closing Thought) and the metaphors are kept.
- Each principle now links to the rule that carries it out.
- Added principles: "Evidence precedes generalization" (sharpened), "Say what
  you know, at the strength you know it", and "Show, then tell", which comes
  from the human's request that the canon "show and speak for itself".
- The Canonical Skeleton gained WHY / WHAT / HOW / COMMON. The detailed pillar
  rules moved to `__Docs__/Architecture.md`.
- "Supports inside Features" (`_Ports` → Core, `_Connectors` → Foundations) was
  removed, superseded by the contracts-and-connectors rules.
- The Emergence Rhythm now puts Foundations before Features, matching observed
  practice.
- "README, Map, Traces" became "why it exists, how it works and the proof that
  it works", carried by the Feature README.
- In the Closing Thought, "`_Connectors` and `_Ports` are the ligaments and
  cries of Features" became "`_Connectors` are the ligaments between owners".
- References to `Tribe.md` and `Transmission.md` were removed. No commit on any
  branch ever contained either file.
- The AI conversation framing moved to this Trail (below).

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
