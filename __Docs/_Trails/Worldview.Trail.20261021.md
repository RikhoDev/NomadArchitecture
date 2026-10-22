---
status: non-canon
kind: trail
origin: ai-assisted
trail_of: ../../Worldview.md
---

# Worldview Trail, 2026-10-21: distilling canon from NomadGameEngineV2

> **Context:** NomadArchitecture had not changed since January 2026, while
> NomadGameEngineV2 (NGE) had applied and revised the method for nine months.
> An analysis compared the two and found that NGE practice contradicted
> several NomadArchitecture rules.
> **Author:** Eric (Shaman), assisted by Claude Code.

## Decisions and review loops

Recorded once, for the canon as a whole, in
[__Docs/README.Trail.20261021.md](Canon.Trail.20261021.md),
with the human's words quoted verbatim.

## What the analysis observed

The NGE evidence is cited rule by rule in `__Docs/Architecture.md` and
`__Docs/README.Trail.20261021.md`.

## What changed in Worldview.md

Compared with the previous version (commit `6851a98`):

- The voice, the structure (Principles, Canonical Skeleton, Emergence Rhythm,
  The Shaman, Closing Thought) and the metaphors are kept.
- Each principle now links to the rule that carries it out.
- Added principles: "Evidence precedes generalization" (sharpened), "Say what
  you know, at the strength you know it", and "Show, then tell", which comes
  from the human's request that the canon "show and speak for itself".
- The Canonical Skeleton gained WHY / WHAT / HOW / COMMON. The detailed pillar
  rules moved to `__Docs/Architecture.md`.
- "Supports inside Features" (`_Ports` → Core, `_Connectors` → Foundations) was
  removed, superseded by the contracts-and-connectors rules.
- The Emergence Rhythm now puts Foundations before Features, matching observed
  practice.
- "README, Map, Traces" became "why it exists, how it works and the proof that
  it works", carried by the Feature README.
- In the Closing Thought, "`_Connectors` and `_Ports` are the ligaments and
  cries of Features" became "`_Connectors` are the ligaments between owners".
- References to `Tribe.md` and `Transmission.md` were removed. No commit on any
  branch in this clone (`main`, `claude/serene-gates-jcd9gw`) contains either
  file.
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
