---
status: non-canon
kind: chronicle
origin: ai
date: 2026-10-22
---

# Chapter III — How NomadArchitecture Was Grown

> **A case study, and the chronicle that comes before Chapter 0.** It was
> drafted by an AI assistant, and the author reviewed and approved it for
> publication on 2026-10-22. It is drawn from the git histories and documents
> of six of the author's repositories, four of them private, and on the
> author's own account of the story. It quotes no
> code and no private document text. Every figure comes from a command in
> [How the figures were obtained](#how-the-figures-were-obtained).
>
> **How to read it.** Following the method, each part says what kind of
> statement it is:
> - *observed*, from a file or commit;
> - *interpreted*, a reading of what was observed;
> - *the author's account*, which this study could not check.

## The problem, as it was lived

*Interpreted, from the lineage below.* NomadArchitecture began as an answer to
one problem: intent leaks. It leaks in four places.

- **From the architect who stops reading the code, to the team that then
  decides alone.** In July 2025, a story written alongside the first sample
  game tells exactly this. An architect, buried in strategy, uses an AI
  assistant to read their own team's code. They find the cost of every
  decision made in isolation. Its last line is that documentation does not
  implement itself. The method's first worldview, three months later, made it
  a rule: no one gets to vanish after drawing the map.
- **From one AI session to the next.** A note from the same summer records
  that the AI assistant has no memory, and invents a plausible history when
  asked for one. The fix it gives is to keep the conversation in a file. That
  file became the method's Trails.
- **From one project to another.** The method's first promise was mobility:
  capabilities that "pack up and join a new convoy with zero friction". In the
  author's account, it came from earlier work projects built as slices. He
  wanted to copy a slice from one project into another, to move Features. A
  Feature that can move is mobile, and mobile suggested nomad.
- **From people to time.** In the author's own account, ideas "tended to stay
  in my head and eventually fade into oblivion."

AI makes every one of these leaks faster, because it writes more, more
fluently, than anyone can read. The method's oldest finding about AI comes
from August 2025: expert execution with junior architectural judgment. It is
an assistant that reaches for enterprise ceremony where a screwdriver would
do.

### The story, in the author's account

The author told this part of the story in October 2026. Where the record can
check it, the lineage below cites what it found.

- **The name and the myth.**
  - The name came first, from mobile slices. It stayed in second place until
    he remembered the nomad tribes of Cyberpunk, his favourite tabletop
    role-playing game.
  - He later dropped the Cyberpunk allegory for fear of copyright. Deserts,
    tribes, families, the fire and the Shaman took its place.
  - He chose that anthropological myth because every model knows human
    history. Nomad tribes, as the cradle of societies, must have understood
    something about structure and organisation.
  - He still thinks the Cyberpunk reference, being ready for technology,
    might work better.
- **Two AIs, two roles.** One AI chat assistant was used for discovery,
  discussion and myth, and an AI coding assistant for code. The first draft of
  the method came from that chat assistant, at a time when many called it the
  weakest. His point was that it isn't about the AI: the quality of what an AI
  produces depends on the quality of the thinking behind it.
- **The architecture is the guard.** Guards were born to keep
  smaller-context models from forgetting the beginning while reading the end.
  The guards are not a feature of the documents; they are the architecture
  itself:
  - the pillars;
  - the Trails, the Chronicles and the READMEs;
  - the canon;
  - most of all the Worldview, which holds the intent and protects the fire.
    Of everything in the method, the author is proudest of it.
- **The hands-off experiment.** To test the ideas at scale, he stopped
  SampleGame and pushed the chat assistant's memory to git as a time capsule.
  He then used the myth to make a coding assistant generate a whole folder
  structure, first for NomadAI, then for the first engine. His rules: he would
  not touch the code; once a prompt was committed, he accepted every
  proposition; and he fixed mistakes only by prompting again. It was fun, and
  it leaked:
  - the context leaked;
  - Foundations ended up referenced by Features;
  - connectors were half understood;
  - Core grew fast.
- **The turn to V2.** Adding DirectX beside raylib, and wanting both backends,
  made dependency management "hellish". He moved the method forward with a new
  worldview and a full refactoring. NomadGameEngineV2 was born as a sprout host
  inside the first engine, the first fractal NomadArchitecture, and was then
  extracted.

### How to read the experiments

In the author's words: "The learnings show the architecture. The experiments
are just that." Every ground in this chapter is an experiment, not a verdict.
None of them is the method, and none is final. What the method is shows in the
loop they share:

1. find what works;
2. make it work at scale;
3. convey it durably;
4. get better, again and again.

It is the learning cycle of the method's first worldview: expression,
experience, evidence, reflection, revision. Read the figures below as one turn
of that loop, not as its result.

### The part most often missed: names that carry intent

The first engine was created from the method's worldview and a complete draft
of what a game engine's folders and files would look like in the method's
canon. Its folder and file names were driven by intent.

*The author's account:* that part is very important, and it is often mistaken
for a secondary one. AI agents have not fully mastered it, and few examples
show what it should look like, which is why there is no definitive proof yet.

*Observed:*
- The second engine named it a contract in its own right in April 2026: a
  path should say what world it is in, what responsibility it carries, and
  whether it is law, intent, machinery, roof, proof or trail, before anyone
  opens the file.
- It keeps a ledger of paths that fail that test, and a script that measures
  it.
- In the onboarding pilot, the arm with code and names alone stayed inside
  the pillars.

## Lineage

*Observed*, except where marked.

| When | Ground | What happened to the method |
|---|---|---|
| 2025-07-15 | SampleGame | A small C# game starts with a "feature-first" architecture: Features, Hosts and input ports on day one. |
| 2025-07-16 to 07-28 | SampleGame | Core appears, then Foundations and connectors, with the first decision records on layers and connectors. The first recorded promotion moves a projectile up into the Features folder. Architecture is explored through "pattern stories", sorted into published books, approved candidates and work in progress. |
| 2025-07-31 | SampleGame | The story of the absent architect. Its afterword labels which parts are reality and which are fiction. |
| 2025-08-03 | SampleGame | The name NomadArchitecture first appears, after the nomad families of Cyberpunk 2020: mobile families with strong internal bonds, linked by a shared vocabulary. The pillars existed before the name, so the metaphor came after the structure. Two decision records are accepted that day. One promotes a concept to Core only when two or more domains need it, to avoid a "God Core". The other lets AI assist under constraints: architectural decisions need human approval. The assistant's instructions file becomes the method's first agent guidance. |
| 2025-08-18 to 08-20 | SampleGame | Lessons on AI as a development team, a pitch "for executives", and an MIT licence. The game has no automated tests: analysis documents and demos are its checks. |
| 2025-10-31 to 11-02 | the method's own repository | First public form, nine days after a last SampleGame story fix. The metaphor changes from nomad families to the camp, the fire and the Shaman. The worldview adds a covenant (AI may scaffold, humans decide) and the principle that the architecture "teaches newcomers by structure and story". It calls the skeleton platform-agnostic. |
| 2026-01-20 | NomadAI | An AI-agent service generated from the myth: Features for an agent runtime, billing and governance, each with Trails, ports and connectors. Two commits, left in that state. |
| 2026-01-25 to 03-07 | NomadGameEngine | The first engine, which started as the sample game's engine. By the author's account, it was created from the method's worldview, copied to its root, and a complete draft of an engine's folder structure; the repository's history begins after that step. Its first commit already holds that draft, a whole engine's Feature families (AI, Animation, Audio, Networking, Physics, Rendering and more), most with ports or connectors. It has 275 commits across its branches (`main` stops at 02-13). Ports and connectors are enforced, a gameplay capability is promoted to a generic Feature, and the evolution rules that both later grounds cite appear. Architecture tests run in CI beside a CODEOWNERS file. A chronicle states the Fractal Laws: a Feature, a team, a department and an enterprise follow the same laws. The leak the author describes is visible: its Features project references Foundations, on `main` and still on 03-01. |
| 2026-01-28 | the method's own repository | The time capsule: a 352-line folder-structure document from the chat assistant's memory, with ports, connectors and a Feature template. |
| 2026-02-13 to 02-16 | NomadGameEngine, branch `vnext-refactored` | The branch forks from `main`. On 02-14, `_Ports` are renamed `_Contracts` across the code. On 02-16 a new worldview, "v1.1", is carried into the engine, a day after it appeared on a coding-agent branch of the method's repository (02-15). It opens with Intent First, "the spark that gives a system its soul". It sets out the Sprout-Host rite: every Sprout-Host is promoted or buried, and every fossil leaves a Trail. And it puts contracts and connectors at every scale. |
| 2026-02-23 | NomadGameEngine, branch `vnext-refactored` | A DirectX sprout host grows in numbered "growth loops", 0 to 13, in one day. Each loop is a commit, and they end in a promoted mesh-draw contract and a chronicle. |
| 2026-02-27 to 03-07 | NomadGameEngine, branch `vnext-refactored` | A dual-backend host wires raylib and DirectX, and a refactoring prepares sturdier plumbing for several backends. On 03-07, `Hosts/_Sprouts/NomadGameEngineV2` is added, with a roadmap for its graduation from sprout into the production engine. The sprout had proven a dual-backend GPU pipeline, and a strict Core ← Features ← Foundations ← Hosts direction enforced by reflection tests. The roadmap is AI-drafted and human-requested. By its count, about 10 of the first engine's ~30 capability areas were production quality, and the rest untested scaffolds. Its first principle for graduation was to port only tested code, never scaffolds. |
| 2026-03-09 to 10-22 | NomadGameEngineV2 | Extracted into its own repository, and the evidence ground below. Its first commit carries a corrected worldview, the heart the engine was then built on. It keeps the February teaching that everything moves, drifts and forgets, and that intent, lineage, ceremony and memory are how a system survives. It fixes the form with what the sprout had proven: an explicit dependency direction, a Feature's edge defined by what it needs and promises, a convention canon, and the rule that reusing an implementation does not make it neutral. |
| 2026-10-21 to 10-22 | the method's own repository | The grounds' findings are distilled into a four-file canon, with mechanisms for authority, provenance and conformance. Mobility, lost on the way, returns as a checked rule. |

## The evidence ground

NomadGameEngineV2 is not a production target. It is where the method was put
under load, to find out what holds when one person and several AI assistants
build a large real-time system together.

| | |
|---|---|
| Period | 2026-03-09 to 2026-10-22, 2,321 commits |
| People | one developer, working with AI assistants from more than one vendor |
| Code | about 400,000 lines of C# in 2,462 engine files, plus a separate test project of about 106,000 lines |
| Tests | 5,248 xUnit tests; 89 of them are architecture tests |
| Hosts | 31: two tools, five games, and 24 "sprout" hosts, each a parallel exploration of one question |
| Documents | about 1,300 Markdown files, about 1.8 million words |

Its rhythm, *observed*:

- **AI eras.**
  - From April 25 to May 8, 112 commits are co-authored by one AI coding
    assistant.
  - From August 15 to 21, a second vendor's agent makes 24 commits under its
    own name. The developer reverts its last one within a day.
  - From September, contributor guidance for AI agents exists. Commits from
    then on record approvals by an "architect" role.
- **Gaps.** There are no commits from 2026-05-30 to 07-13. Then 19 commits land
  within minutes, carrying documents dated June and July, so commit dates in
  that period show when work was committed, not when it was done.

Sprout hosts are how the ground explores. *Observed:* six terrain hosts make
no reference to one another, and each speaks only to the shared terrain
Feature. A later case file maps what each contributed, extracts the law they
share, and reconciles them through gated comparisons. *Interpreted:* the file
system is the coordination medium for minds that share no memory.

## What each exploration changed

| Idea | Where it was tested | What the evidence did to it |
|---|---|---|
| Letting the AI drive | NomadGameEngine | Under the author's hands-off rules, Features came to reference Foundations. The graduation roadmap's own count is about 10 production-quality capability areas out of ~30; the rest were untested scaffolds. In the second engine, Features reference only Core, and its build and tests enforce that. *Interpreted:* much of the canon reads as scar tissue from letting an assistant drive. |
| Ports and connectors | SampleGame, then NomadGameEngine | Ports came on day one and connectors on 07-27; the first engine enforced them. They became NomadGameEngineV2's contracts and connectors. The canon keeps connectors and retires `_Ports`. |
| A `_Contracts/` folder at every layer | the first engine, then NomadGameEngineV2 | It was born in the first engine on 2026-02-14, when `_Ports` were renamed `_Contracts`, and the February worldview made it a rule at every layer. The corrected worldview kept it, but already said that a contract stays with its one consumer until others need it. In the second engine, six months showed such a folder owns nothing. On 2026-08-25 the rule was reversed: a contract lives with the owner of its meaning. 103 of the 110 files ever added to these folders predate the reversal, and the folders that remain are tracked as migration debt. |
| Promotion | all three grounds | SampleGame: promote to Core when two or more domains need it, and avoid a God Core. The first engine promoted a gameplay capability to a generic Feature. The second refined the rule: two real consumers are enough, a difference between them is evidence and not a veto, and a third is never invented. In one case, duplicated route planning moved from two hosts into a new Feature, backed by a 98-test regression. In another, only a shared law was promoted, and the code stayed local. |
| Humans decide | all three grounds | A SampleGame decision record (2025-08-03), then the covenant (2025-11-02), then the second engine's guidance (2026-09-11). When an AI assistant later held the architect role, approvals recorded as "Architecture" could no longer be traced to the human. The principle survived as a sentence and never became a mechanism. The canon now makes it one: named canon owners, and a declared authority on every canon commit, checked in CI. |
| The Worldview | all grounds | It is the heart of the architecture. The first engine's worldview carried the intent but got the form wrong: its Features were allowed to lean on Foundations. That engine's lessons grew the V2 sprout, and the sprout's lessons gave birth to the corrected worldview. That worldview became the basis of the V2 engine, and the culture kept moving from there: the `_Contracts/` reversal, the worldview made the first contributor reading, and finally the method's canon. In the author's words, it is what "holds the intent and protects the fire". |
| Sprouts | the February worldview's rite | Every Sprout-Host is promoted or buried, and every fossil leaves a Trail. NomadGameEngineV2 itself grew as a sprout host inside the first engine and graduated into its own repository. The method's own October branch now lives as a sprout beside its `main`. |
| Status of documents | SampleGame's stories | Stories moved from work in progress to approved to books, with superseded versions archived. That became the canon's status header, and Mirages, Chronicles and Trails kept apart from the canon. |
| Labelling claims | SampleGame's afterword on reality and fiction | It became the canon's rule on claims: observed, interpreted or unknown. |
| Memory across sessions | SampleGame's note on what an assistant cannot remember | Trails, and later a plugin that loads the working discipline into every session. |
| Narrative | SampleGame's pattern stories | The method's Chronicles and Worldview carry its culture as story, not as rules. The metaphors changed twice while the structure held, so they behave like Hosts: replaceable skins over a soul that stays. |
| Mobility | SampleGame's first promise | It was lost from the method's repository: no rule there named it. The pillars still held the shape that makes it possible. In October 2026 it returned to the canon as a rule that every Feature, less its connectors, needs only Core, with a test that holds it. A real move followed. A Feature joined a second system unchanged, and the move showed what the test could not: the Feature's contract still spoke its first system's language. |
| Checks in CI | NomadGameEngine had them | The second engine ran its tests locally; why is not recorded. The canon puts them back. |
| Writing everything down | NomadGameEngineV2 | About 1.06 million words of exploration against about 19,000 of binding decisions. Nothing yet says when an exploration ends. The canon answers in part: a short listed canon, status on every document, and AI conversations kept apart. |

## What the grounds produced

- **A large system whose architecture held.** The dependency direction held
  through 31 hosts, several AI assistants and seven months of change.
  - Build files enforce it: connectors are compiled only by the composition
    project, so a Feature cannot reach another Feature by accident.
  - The architecture tests carry an empty list of known violations.
- **Rules corrected by evidence instead of defended.** The `_Contracts/`
  reversal and the law-only promotion both overturned or narrowed the
  method's own earlier position.
- **Debt named, not hidden.**
  - A ledger records paths whose names carry no architectural meaning: ten
    entries, six open.
  - Case files name the remaining contract folders and give their migration
    target.
- **Its own mistakes kept.** The records keep the AI's errors beside its
  successes:
  - a doctrine rewrite reverted within 72 minutes;
  - a duplicated rule caught only by rereading the diff;
  - a conclusion first stated too strongly, then corrected.

  The plugin's "compare with the base" step came from those records, and they
  fed the canon's rules on claims.
- **A probe of AI contributors.** In October the ground was used to test
  whether a fresh AI session verifies before building, holds to evidence, and
  keeps the canon small. Revising under contradiction held in every run.
  Keeping the canon small held only when it was easy. These are one or two
  runs per condition, and the probe says so.
- **A first look at "structure and story".** In a cold-onboarding pilot in the
  method's repository, fresh AI sessions made three real changes. One arm had
  the whole repository, the other the code alone.
  - Both arms stayed inside the pillars: the structure taught.
  - Only the arm with the documents held back from promoting code for a
    single caller: the story taught why.

  It is one run per cell, judged by an AI against the canon itself.

## What an organisation can take from it

- **The method is a product of evidence, not of a framework designer.** Each
  rule in the canon can be traced to the ground that earned it, or that
  overturned what came before.
- **Its subject is transmission.** Governance is the part that keeps
  transmission honest when an AI writes most of the words:
  - who decided;
  - what binds;
  - what proves it.
- **Exploration needs governance a team can audit.** The grounds worked for
  one person who held the whole history in mind. What a team needs on top
  was found by running into its absence:
  - authority that can be traced;
  - checks that run without anyone remembering to run them;
  - an end for explorations.
- **The same laws, at every scale, is the claim still to test.** The Fractal
  Laws say a team is a sovereign unit like a Feature: its own boundary, its
  own memory, and a shared vocabulary promoted only when two teams need it.
  That is the method's answer to Conway's law. Nothing here shows it beyond
  code.

## Limits of this evidence

- **One developer,** who is also the author of the method. No other team has
  used it.
- **SampleGame was read through its history and documents only.** Its code
  was not built or run.
- **Counts, not outcomes.** The figures describe the repositories' state; they
  do not measure defect rates, delivery speed or onboarding time.
- **Thin probe evidence:** one or two runs per condition, designed and scored
  by the people under study.
- **Mobility is shown by one move, made for the purpose.** On the day this was
  published, Reminders moved from the reference billing system into a second
  one, unchanged, with its proof. That move is within the method's own
  repository, not between teams.
- **Steered research.** An AI assistant working for the author gathered and
  interpreted these facts, partly under the author's hints. A second
  assistant checked the figures against the git histories, and a third,
  briefed only as a sceptical CTO, reviewed the method cold.

## How the figures were obtained

From each repository's default branch, or the branch named, at 2026-10-22,
with full history.

| Figure | Command |
|---|---|
| Dates and commit counts | `git rev-list --count HEAD`; `git log --reverse --format=%ad \| head -1` in each repository |
| When SampleGame's concepts appear | `git log --all --reverse -i --grep=<concept>`, and `git log --diff-filter=A` on each decision record |
| SampleGame has no automated tests | `git grep -c -E '^\s*\[(Fact\|Theory\|Test\|TestMethod)' HEAD -- '*.cs'` returns 0 |
| No mobility in the method's repository before October 2026 | `git log --all -S mobility` and `-S Cyberpunk` return nothing |
| The first engine's CI | `.github/workflows/architecture-check.yml`, first added on 2026-01-27 |
| Second engine's code size | `find Engine -name '*.cs' \| xargs cat \| wc -l`, and the same for the test project |
| Tests | `git grep -E '^\s*\[(Fact\|Theory)' HEAD -- '*.cs' \| wc -l` |
| Documents | `find . -name '*.md' \| wc -l`; `... \| xargs cat \| wc -w` |
| `_Contracts/` files before and after the reversal | `git log --diff-filter=A --name-only` on `*/_Contracts/*`, split at 2026-08-25 |
| The second engine has no CI | `git ls-tree -r --name-only HEAD \| grep -c '^.github/workflows'` returns 0 |
| Contributor guidance first appears | `git log --diff-filter=A` on `AGENTS.md` |
| AI eras | `git log --format='%ad %(trailers:key=Co-authored-by,valueonly)'`; `git log --author=<agent>` |
| The revert | `git log -1 --format=%ci` on the change and on its revert |
| The worldviews compared | headings of the first engine's `Worldview.md` at 21ead4e against the second engine's `Engine/__Docs/Worldview.md` at its first commit (a5da6a575) |
| The `vnext-refactored` branch | `git log --reverse <merge-base>..origin/vnext-refactored`, and `git show` on its Worldview commit (21ead4e) and its roadmap commit (3ac35b4) |
| The first engine across its branches, and the V2 sprout | `git log --all`; `git ls-tree -d` on the commit that adds `Hosts/_Sprouts/NomadGameEngineV2` |
| Features referencing Foundations in the first engine | `ProjectReference` lines of `src/Features/Features.csproj`, on `main` and on 2026-03-01 |
