---
status: non-canon
kind: trail
origin: ai-assisted
trail_of: ../README.md
---

# Trail of the canon, 2026-10-21

How the canon listed in [README.md](../README.md#canon) came to be: a session in
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
| Host → Foundations → Features growth | NGE:`README.md`, Promotion Flow, committed as RikhoDev on 2026-10-20 (`812341a`). It reverses the 2025 order in `Worldview.Trail.20251102.md` ("Host → Features → … → Core → Foundations"). Reading the newer text as superseding the older is the assistant's interpretation |
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
- **Moved to the Mirage:** the OBS / INF / UNK / PROP labels. The canon keeps
  the words; nothing here used the labels.
- **Restored:** the Worldview's voice (tent, clans, ligaments, ground,
  memory). The second review noted it had been lost, and it is the part most
  clearly the human's.

## Loop 2 review

A third isolated review advised returning the assistant-decided items to
`proposed`. The assistant held: item 6 delegates the decision itself, so
handing it back would undo the request. Instead, the canon README now says
which parts were delegated, and that nothing has been read by the human yet.
Also applied from that review:

- `origin: ai` on text the human did not write;
- missing "Replaces" lines;
- the connector guide no longer restates Architecture;
- the claim-label contradiction;
- the example's lineage path.

Kept against its advice:

- the three canon lists, because the check reconciles them, each has a
  different reader, and the plugin needs its own file;
- the pillars in both Worldview (essence) and Architecture (rules).

## Loop 3: the DocReader Host

The human's words:

7. "feature template is stale and useless as it is. Using nomadarchitecture
   itself to have a nomadarchitecture doc reader coded inside the repository for
   demonstration could be cool. Would be a host that would contain its local
   pillars and showcase how things go together with the appropriate
   explanations and all, what do you think of this?"
8. "do both, fix canon as you build the host."

"Both" covered two choices the assistant had offered: put the Host at the
root, and fix the canon labels first. What changed:

- **Canon labels.** An acceptance review, run with nomad-method 0.2.0, found
  that `canon` was defined as "doctrine the human has authorized" while the
  README said the human had not read it. The plugin's own new delegation rule
  agreed with the review. The rules inferred from the human's record stay
  canon. The three sections the assistant decided are now listed in an
  `awaiting_reading` header, and bind no one until read:
  - `Worldview.md#emergence-rhythm`
  - `__Docs__/Architecture.md#feature-readme`
  - `__Docs__/README.md#folder-grammar`

  "Any of it stands until the human contradicts it" was removed; it put the
  burden on the human.
- **`Hosts/DocReader`** holds its own Features (Canon, Lineage, Placement)
  and a Foundation (Markdown), each with its README and proof, plus a Host
  proof that runs the real commands. Its tour, `canon` and `explain` read
  their words from the READMEs, so the documents are what speak. The
  assistant's outline listed `Lineage` and `Placement` under those names;
  nothing else was planned in advance.
- **`FEATURE_TEMPLATE.md` was deleted.** The human called it stale and
  useless, and the Host's Features are now the template.
- **The orphaned root guides moved** from `Features/_Ports/` and
  `Features/_Connectors/` to `__Docs__/Concepts/`. The root then shows only
  the pillar that exists, `Hosts/`.
- **The checkable claim from the review was fixed:** "contradicts none of the
  rules" is gone. The connector guide no longer says "imported from both
  sides", which Architecture does not say.
- **First use of a Mirage idea.** The Placement Feature names worlds
  (repository, memory, system, examples) much as the Three-worlds Mirage
  does. That is one consumer of the idea, so it is not a promotion.
- **Promotion candidate, not promoted.** The Markdown Foundation and
  `Scripts/Test-Repository.ps1` parse headers and links twice. The evidence is
  recorded in the Foundation's README for the human to see first.
- **Not taken from the review:** moving "Replaces" lines out of doctrine,
  because this README's growth rule requires them there.

### Loop 3 review

An isolated review with nomad-method 0.2.0 found:

- the `awaiting_reading` rule was itself decided by the assistant, but was
  not marked as awaiting; it now is (`#status-header`);
- "two independent consumers" overstated the promotion evidence;
- "Settled" claimed more than the proofs show;
- the Host proof was tied to the sections that happen to await reading;
- a wrong anchor in the Lineage README.

All are fixed. The loop-3 commit message (`4f4f9d4`) gave the proofs as "5
files with 40 claims"; there are 6 files with 36.

## Loop 4: the folder grammar of NGE

The human's words:

9. "remove greeting, and merge __Docs__ into __Docs, same for mirages, etc.
   fix the naming convention on the folder to match the true vision. Use
   NGEv2 for context on that fix."

This reverses one of the assistant's calls in Loop 2, "the wrapped form
stays". The folder grammar now restates NGE's Naming Conventions. Because the
human directed that, it does not await reading. The assistant's additions do:
the `date:` header field and the `-Chronicle`/`-Mirage` suffixes, in
`#dates-and-suffixes`.

The isolated review of `08f1700` corrected two claims:
- the time capsule's month: its old name, `20060119`, and its first commit,
  2026-01-28, both point to January 2026, but neither proves when it began;
- the proof count: `08f1700` said 6 proof files; there are 5.

Greeting was removed, and git records the renames.

Not done, and offered to the human: NGE keeps Trails in `_Trails/` folders
under their owner, with descriptive names. Here they still sit beside their
documents, named `<Document>.Trail.<YYYYMMDD>.md`. Moving them would change a
canon rule and how the Lineage Feature finds a Trail. It would also take the
three Worldview Trails out of the root.

## Loop 5: Trails move into `_Trails/`

The human's words:

10. On the extraction: "should be good to go." On the next stage: "step 4
    first, then 3". Step 4 was the assistant's offer to move the Trails into a
    `_Trails/` folder, as NomadGameEngineV2 does.

What changed:

- All thirteen Trails moved into `__Docs/_Trails/`. The root now holds only
  `AGENTS.md`, `Hosts/`, `LICENSE`, `README.md`, `Scripts/`, `Worldview.md`
  and `__Docs/`.
- `README.old.md` was the README's own record, so it is a Trail:
  `Root-README.Trail.20251031.md`. It is dated by the last commit of its
  content (`8d07e9e`, 2025-10-31), before it was renamed. Its old label,
  `superseded`, became `non-canon`, because a Trail is history, not a
  replaced rule.
- Three Trails would have shared the name `README`, so they are named for
  their owner: `Canon.Trail.20261021.md` (this file),
  `Chronicles-README.Trail.20251103.md` and `Root-README.Trail.20251031.md`.
- A Trail now names its document in a `trail_of:` header. This is the
  assistant's addition, defined in the status header section, which already
  awaits reading. The Lineage Feature finds Trails by it, and
  `Test-Repository.ps1` fails on a Trail outside `_Trails/` or a `trail_of`
  that points nowhere. Two mutations confirmed this.
- Every relative link, inside the moved Trails and toward them, was rewritten
  from both ends.

### Step 4 review, and a trial run on nomad-method

The isolated review of `7caa9af` found:
- four link labels that still read `README.Trail.20261021.md`;
- a naming rule that three Trails broke;
- an NGE citation that supported only the folder, not the naming or
  `trail_of:`;
- loose wording on the root README Trail's date;
- a hand-kept list of residents in `_Trails/README.md` that would go stale.

All are fixed. The naming rule now says `<Owner>`, the check enforces it, and
the list is gone. The Genesis Chronicle still mentions `README.old.md`; that is
story text, kept as written.

Running this repository's tools against a copy of `RikhoDev/nomad-method`
found two bugs in them:
- `Test-Repository.ps1` crashed when `.nomad-method/canon` or the canon index
  was missing. It now reports what is missing.
- A README whose first line is an HTML image gave that tag as its lead. Leads
  now skip lines that are only HTML, with a proof.

## Still open

- The DocReader's own next steps are kept in its README's Status.
