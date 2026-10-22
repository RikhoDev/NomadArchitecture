---
status: non-canon
kind: trail
origin: ai
trail_of: ../Architecture.md
---

# Canon change: names that read as phrases, and what a move costs

Decided by the assistant from the author's own words, under the delegation
quoted in the commit. Marked `placement` and `pillars` in Architecture's
`decided_by_assistant` until a canon owner reads them.

## The conversation that led here

- The assistant proposed fixing "the travelled Reminders' namespace". The
  author asked what that was, having taken it for a mystic concept the
  assistant wanted to add.
- The phrase showed the assistant's mistake: it treated a Feature as
  belonging to a system and visiting another.
- The author set the rule: "The mystic should stay in the documentations and
  code should be direct, precise, descriptive and obvious to read as a
  phrase." He also set what mobility costs: "a full copy-paste approach is of
  course unconceivable, but if it's only about changing a namespace and an
  interface or two, we're good."
- He had already said that intent-driven folder and file naming is very
  important, often mistaken for secondary, and not yet mastered by agents.

## What changed

- **Placement, Explorer test.** Amended, not added to. Below the first level,
  a path says what it owns and what kind of thing it is. Code is named
  plainly, so that a path or signature reads as a phrase. The myth belongs to
  the documentation. The source is NGE's name-signal Mirage, which is still
  Proposed there; its five questions are condensed into one sentence.
- **Pillars, Feature.** "Pack up and leave" becomes what a move costs: a
  namespace and an interface or two. A full copy-paste is not the aim.

## The code that broke the rule, fixed in the same commit

- Billing's conformance test `Every_Feature_can_pack_up_and_leave` is now
  `A_Feature_outside_its_connectors_depends_only_on_Core`.
- Its comment and failure message are rewritten in plain language.
- Two Rentals build files said "Travelled" and "travels". They now say what
  they do.

The documents keep their stories.
