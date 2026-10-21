---
status: non-canon
kind: trail
origin: ai-assisted
---

# Trail of the canon, 2026-10-21

How the canon listed in [README.md](README.md#canon) came to be: a session in
which Claude Code, running the nomad-method plugin, analysed this repository
against NomadGameEngineV2 (NGE).

## The human's words

Quoted verbatim, in order:

1. "Time to test our new plugin. use it to analyse nomadarchitecture repo."
2. Asked what kind of analysis was wanted: "use the claude branch on NGE v2 to
   get the context and plan for nomadarchitecture's base repo's improvement
   based on full analysis. Give me your thoughts and opinions."
3. "interesting indeed. Proceed."
4. Four choices, from options the assistant offered:
   - Role of NomadArchitecture: "Small base canon (Recommended)"
   - Old `_Ports`, fallback and connector-promotion rules: "Supersede, keep
     files (Recommended)"
   - AI chat text inside documents: "Separate them (Recommended)"
   - Canon size: "Rule, no numbers"
5. After the first review: "well probably time for the first loop, then.
   continue with the method, I'm curious to see how far it can lead us."
6. After the second review, the authorization for this canon: "From what you
   know of me, my goals, the story of my personal projects, as well as the
   work we've done plus the proofs we have everywhere, I think you can infer
   what II would deem canon from the get go. For the rest, you debate with
   yourself, but remember nomadarchitecture's mission and goals, these should
   have the canon show and speak for itself. Use this rupture to move the
   topic forward."

## The loops

- **Draft, `6d44ae4`.** A new canon distilled from NGE. An isolated reviewer
  (the plugin's judge, which sees the change but not the author's reasoning)
  found the files labelled canon before the text was approved, three of the
  draft's own rules broken, and canon grown from about 100 lines to about 420.
- **Loop 1, `8f15089`.** Relabelled everything `proposed`. Moved Three worlds,
  the recursion inside a Feature, Realization, evidence levels and doctrine
  maturity into a Mirage (the author's move, on the reviewer's advice). Moved
  AI conversation framing from the Chronicles and Mirages into Trails. A second
  review found the pillars restated three times, Promotion detail still
  imported from NGE, inconsistent guide statuses, the only example
  contradicting the connector rules, and the human's decisions recorded in the
  assistant's paraphrase.
- **Loop 2, this change.** Answers item 6 above.

## Inferred from the record: what the human already holds as canon

Each item below rests on something the human wrote, kept, or approved.

| Rule | Evidence |
|---|---|
| The 2025 principles, metaphors and Shaman role | The human's corrections in `Worldview.Trail.20251102.md` and `Worldview.Trail.20251103.md`: "Core is not DNA, it is the product of reflection", "Use Shaman instead of Architect", "Remain humble and factual" |
| WHY / WHAT / HOW / COMMON | NGE:`Engine/__Docs/Patterns/Feature-Sovereignty-Doctrine.md` calls these "the inherited, strongly supported principles", inherited from this repository |
| Placement test, authority stages | NGE:`AGENTS.md`, the contributor guidance; its visible history is committed under the human's account (RikhoDev), and earlier history is unknown because the clone is shallow |
| Contracts and connectors | NGE:`README.md`: "One sentence should survive that reading" |
| Host → Foundations → Features growth | NGE:`README.md`, Promotion Flow, the second sentence that "should survive" |
| Two independent consumers | NGE ADR 0011, status "Accepted", 2026-09-30 |
| Observed, interpreted, unknown kept apart | The nomad-method plugin's working discipline, which the human published |
| AI fabrication needs evidence | Chronicle II, *The Shaman and the Spirit's Hallucinations* |
| Canon must show and speak for itself | Item 6 above, which became the principle "Show, then tell" |

## Debated by the assistant: the rest

Each of these is the assistant's call, made under item 6, and open to the
human's contradiction.

- **Map.md and Traces.md: superseded by one Feature README.**
  - For keeping them: they are original to this repository.
  - Against: NGE has neither file after nine months, and three files per
    Feature split one story across three owners.
  - The five README questions keep the same why / how / proof.
- **Caravans: moved into `_Mirages_/Caravans/`.**
  - It was never consumed by anything found, and NGE says it "does not need
    manifests or YAML".
  - Kept for lineage, but out of the root, where it failed the Explorer test.
- **Folder grammar: the wrapped form stays.**
  - Renaming `__Docs__` to match NGE's `__Docs` would break every link for no
    gain in meaning.
- **A runnable example: added, in PowerShell.**
  - "Show, then tell" needs one.
  - PowerShell is the toolchain of NGE's Scripts and of the original example.
  - The example shows absence as well as presence: no Core, no Foundations,
    no connector, each with its reason.
- **A repository check: added.**
  - It is the seed of the "Nomad Linter" imagined in the EventTrail Mirage.
  - It fails when a header, a link, the canon list or a proof is wrong.
- **Kept in the Mirage:** Realization, Three worlds, evidence levels, doctrine
  maturity, the recursion inside a Feature, and ADR 0011's full variance
  classification.
  - Either NGE itself holds them as under validation, or this repository has
    no case to test them on.
  - Promotion would need two real consumers, by the rule above.
- **Dropped:** the OBS / INT / UNK / PROP labels. The words are kept; nothing
  here used the labels.
- **Restored:** the Worldview's voice (tent, clans, ligaments, ground,
  memory). The second review noted it had been lost, and it is the part most
  clearly the human's.

## Still open

- The time capsule's file name, `20060119`, probably means 2026-01-19. It is
  unconfirmed, so the file has not been renamed.
- `Features/_Ports/` and `Features/_Connectors/` at the root are guides with
  no Feature beside them. They predate the example and may belong inside it.
