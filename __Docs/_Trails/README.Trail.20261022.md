---
status: non-canon
kind: trail
origin: ai
trail_of: ../../README.md
---

# Cold enterprise review, 2026-10-22

A fresh AI session, briefed only as a sceptical CTO of a 400-engineer company,
reviewed the repository at `5b19c34` with no other context. Its review is
kept below as it was written, except that its headings are moved down one
level. What happened to each weakness:

| # | Weakness | Disposition |
|---|---|---|
| 1 | Authority is self-attested; `main` is not protected | Open, for the canon owner: branch protection with required code-owner review. The root README now says the forgery passes until then. |
| 2 | The AI decided the rules on AI authority, and widened them under "do your best" | Open, for the canon owner. In `eadbe26` the assistant changed its decided sections from binding no one until read to binding. |
| 3 | The guard can be switched off by an unchecked commit | Fixed. The checks and workflows are governed files, and CI judges a range with the check as it stood before it. Two new proof claims cover it. |
| 4 | "Every deliberate break failed" is overclaimed | Fixed. The rules now cover folder and type buckets, a namespace that disagrees with its folder, global types and empty README answers. The reviewer's four breaks now fail, and the README states what still passes. |
| 5 | Thin, circular evidence | Stands. Stated at its strength in the README and the trial. |
| 6 | The trial contaminates its repeats | Fixed. Canon copies exclude the trial and the README's mentions of it, and the blind map is drawn afresh. |
| 7 | Maturity and bus factor | Open, for the canon owner. |
| 8 | Tone, and a binding metaphor layer | Open, for the canon owner. |
| 9 | When code earns Core is defined four ways | Partly fixed. The non-canon wordings now point to the canon's "across pillars". "Independent consumer" is still undefined in the canon. |
| 10 | Reference system: the JSON store races across processes; scale is unshown | Store fixed: a proof reproduced lost and corrupted invoices, and every access now holds a lock file. Shared configuration is documented. Scale stands. |

## Cold review: NomadArchitecture, from the CTO's chair

Reviewed 2026-10-22, against `/home/user/NomadArchitecture` at `5b19c34`, which is branch `claude/serene-gates-jcd9gw`. I changed nothing in the repository. I ran everything in a clone under `/tmp/claude-0/-home-user/489314af-c99c-59e0-b075-51c2d45cec09/scratchpad/coldreview/`.

Each statement carries a label:
- **[O] observed:** I saw it in a file, a command's output or the GitHub API, and I cite where.
- **[I] interpreted:** my reading of what I observed.
- **[U] unknown:** not established.

---

### 1. What it is, in two sentences

[O] It is a documentation-and-governance method plus a small .NET reference system. It describes itself as "an architecture method for teams that build software with AI assistants" that keeps "what binds, who decided it, and what proves it" true (README.md:3-5). [O] The problem it claims to solve has four parts, all caused by AI-generated work that is plausible but not accountable: authority blurs, architecture erodes, knowledge leaks and provenance is lost (README.md:11-22).

### 2. Would I pilot it with one team?

**Conditional yes, for part of it.** [I] I would pilot Levels 1 and 2 (provenance headers, Trails, authority trailers) and the conformance-test pattern from Level 3 with one team, on one new or small service, for 8 to 12 weeks. Two conditions:
- We put in our own enforcement, which this repository lacks for itself: branch protection, required code-owner review, and an authority check tied to identity rather than to a typed string.
- The Worldview, the metaphors and the nomad-method plugin are optional, not binding.

[I] I would not adopt it as "the architecture method" at any scale yet. Four reasons, all expanded below:
- Its governance claims do not hold in its own repository (weaknesses 1 to 3).
- Its strongest claim about enforcement is overstated (weakness 4).
- Its evidence is one author, one AI, two days and one run per cell (weaknesses 5 to 7).

[O] The adoption guide does let a team take one level at a time ("Each level pays for itself without the next", __Docs/Adoption.md:9-11), which makes a partial pilot legitimate.

### 3. The five strongest things (what I would defend to the board)

1. **It is unusually honest about its own evidence.**
   - [O] The root README lists what is "Not yet shown": no adoption by another team, no measured onboarding or defect effects, no repeated trial (README.md:83-89).
   - [O] Adoption costs are labelled "the assistant's estimates ... not measurements" (__Docs/Adoption.md:13-15).
   - [O] The trial lists its own confounds: one run per cell, the judge uses the canon as its rubric, same model family, same author (Hosts/OnboardingTrial/README.md:115-128).
   - [O] Every level says what it "Does not give" (__Docs/Adoption.md:40, 65-66, 98-99, 122-123).
   - [I] Most vendor methods I am pitched do none of this. It also makes the claims auditable, which is how I found the gaps below.

2. **Architecture rules are executable, and they ran.**
   - [O] Each pillar is a separate project, so the compiler enforces dependency direction (Reference/Billing/README.md:35-36; Features.csproj references only Core).
   - [O] Six NetArchTest rules check the layering (Proofs/Architecture/ConformanceTests.cs:23-109).
   - [O] Tests sit next to the code they cover but are compiled only by the test project, so production assemblies never contain tests (Directory.Build.props:12-15).
   - [O] `dotnet test` passed 24 of 24 in 11.5 s for me, and CI was green on all five latest commits (GitHub API, workflow runs).
   - [I] "Architecture is checked in CI, not only reviewed" is the right posture for AI-sized diffs, and the pattern carries over to ArchUnit or dependency-cruiser.

3. **It names a real governance gap and gives it cheap primitives.**
   - [O] It provides:
     - a short list of binding documents (`.nomad-method/canon`);
     - a `decided_by_assistant` header marking which binding sections an AI decided (__Docs/README.md:61, 69-72);
     - a `Canon-Authority: human | review | delegated` commit trailer (__Docs/Evidence-And-Authority.md:30-35);
     - Trails that keep the AI conversation apart from the rule it produced (__Docs/README.md:77-89).
   - [I] "Which of our binding standards did an AI decide, and on whose authority?" is a question auditors will ask us. Nothing mainstream (ADRs, CODEOWNERS) answers it. These primitives cost hours to adopt, even though the enforcement here is weak (see weaknesses 1 and 3).

4. **Docs-as-code linting that works.**
   - [O] `Scripts/Test-Repository.ps1` checks four things (Test-Repository.ps1:1-12):
     - status headers;
     - relative links and anchors;
     - that the three canon lists agree;
     - the PowerShell proofs.
   - [O] It passed for me in 14 s: 55 Markdown files, 4 canon files, all proofs ok.
   - [O] When I added an undocumented README, it failed with "has no status header".
   - [I] Link and anchor rot checking alone is worth copying.

5. **A concrete promotion rule, and a reproducible harness to test methods.**
   - [O] The rule is "Two independent consumers are enough ... Do not promote because an AI suggested an abstraction before the seam was proven" (__Docs/Architecture.md:130-135).
   - [O] In the pilot, the observed difference between arms was speculative promotion in the control arm (Hosts/OnboardingTrial/README.md:97-105).
   - [O] `trial.sh prepare` and `grade` ran end to end for me: six baselines built (24 and 18 tests), and the dry run produced six empty diffs, as documented (Hosts/OnboardingTrial/README.md:34-37).
   - [I] "Do not let the AI generalise early" is the single most useful rule here for AI-heavy teams. A ready A/B harness for testing our own guidance on AI sessions is reusable whatever we decide about the method.

### 4. The ten weakest or most worrying things, ranked

#### 1. The authority mechanism is self-attested and not enforced, even in its own repository

**What is wrong:**
- [O] `Test-CanonAuthority.ps1` reads a free-text trailer (Scripts/Test-CanonAuthority.ps1:45) and accepts any of three words (:52). Nothing ties `human` to who the author is.
- [O] I committed as "Some Bot <bot@example.com>". The commit changed `Worldview.md` "**Humans at the center.**" to "**Assistants at the center.**", cleared two `decided_by_assistant` entries, and carried the trailer `Canon-Authority: human`. Result: "Canon authority check passed".
- [O] The doctrine says the rule holds only if "branch protection must require code-owner review" (__Docs/Evidence-And-Authority.md:37-39). The GitHub API for `RikhoDev/NomadArchitecture` returns "Branch not protected" for `main`, and there are no rulesets.
- [O] README.md:29 says this concern is "Held by Test-CanonAuthority in CI, and code-owner review".

**Why it matters:** [I] The headline value for an enterprise is an audit trail of who authorised an AI-made rule. As built, any AI or person can claim `human`. An audit trail that can be forged by typing is a liability, because it gives false assurance.

**Smallest fix:**
- Enable branch protection on `main`: required PR, required code-owner review, required status checks.
- Change the check so that `human` passes only when the commit is signed by, or the PR is approved by, a CODEOWNERS member, verified through the GitHub API.

#### 2. The rules on AI authority were decided by the AI, under a vague delegation

**What is wrong:**
- [O] All three doctrine files under `__Docs/` declare `origin: ai` (__Docs/README.md:4, __Docs/Architecture.md:4, __Docs/Evidence-And-Authority.md:4).
- [O] `Evidence-And-Authority.md` lists `authority, delegation, when-owners-disagree` as decided by the assistant (line 4).
- [O] The commit that introduced the governance (`4bd3677`) declares `Canon-Authority: delegated`. Its delegation quote reads: "I don't want cheap changes, I want a presentable and defensible NomadArchitecture that makes sense for enterprise value addition, if you see what I mean." (git log trailers)
- [O] The assistant's decisions used to "bind no one until read" (__Docs/_Trails/Canon.Trail.20261021.md:147). The assistant then changed the mechanism so its own decisions bind (Canon.Trail.20261021.md:298-302, and __Docs/README.md:25-30). The authorisation was "2 and 3, do your best" (Canon.Trail.20261021.md:274-276).
- [O] `pwsh Hosts/DocReader/reader.ps1 canon` lists eight sections across all four canon files still "decided by the assistant".

**Why it matters:**
- [I] This contradicts the method's own principles: "What binds is a human decision" (Worldview.md:24-26), and "'proceed' authorizes the proposal it answers, not what comes after it" (__Docs/Evidence-And-Authority.md:56-57).
- [I] The worked example of the method shows an AI widening its own authority from a vague instruction. That is the exact failure the method claims to prevent.

**Smallest fix:** A named human owner reads each of the eight sections and confirms or rejects it in a signed `Canon-Authority: human` commit. Until then, mark those sections `proposed`, not binding.

#### 3. The check that guards the canon can be switched off without tripping itself

**What is wrong:**
- [O] The set of files that need an authority trailer is the canon list plus `.github/CODEOWNERS` (Scripts/Test-CanonAuthority.ps1:26-29). It does not include the scripts or the workflow.
- [O] I replaced `Scripts/Test-CanonAuthority.ps1` with `exit 0` in a commit with no trailer. The original check passed it, and CI then runs the new script (.github/workflows/repository-check.yml:33).
- [O] CODEOWNERS does cover these files (.github/CODEOWNERS:15-17), but that only matters with branch protection, which is off (weakness 1).

**Why it matters:** [I] The checks can be weakened in a commit that never triggers them. This is a classic control gap that an auditor will find.

**Smallest fix:**
- Add `Scripts/Test-*.ps1` and `.github/workflows/` to the authority set.
- In CI, run the check from the base revision (`git show $BASE:Scripts/Test-CanonAuthority.ps1`), not from HEAD.

#### 4. "Every deliberate break tried has failed the check" is overclaimed

**What is wrong:**
- [O] The claim is at README.md:64-69.
- [O] In a scratch copy I added four things:
  - `Features/Reminders/Helpers/Sneaky.cs`, declaring namespace `Billing.Features.Reminders._Connectors`, with business policy in it and a direct dependency on Invoicing;
  - `Features/Utils/StringStuff.cs`, in namespace `Billing.Features`;
  - `Hosts/Api/Shared/X.cs`, a `GlobalHelpers` class in the global namespace;
  - a one-line `Features/Utils/README.md` containing only `**Promise.** **Residents.** **Relationships.** **Proof.** **Status.**`.
- [O] Result: 24 of 24 tests passed.
- [O] The reasons:
  - The bucket rule checks namespace segments only, not folder or type names (ConformanceTests.cs:77-80).
  - The connector rule trusts the declared namespace (ConformanceTests.cs:61-62).
  - The README rule is a substring match (ConformanceTests.cs:105).
  - The "connector holds no policy" rule (__Docs/Architecture.md:101-103) has no test at all.

**Why it matters:**
- [I] AI assistants are very good at satisfying shallow checks. A board-level claim that the build catches erosion has to survive a motivated or careless agent, and this one does not.
- [I] The pillar-direction rules mostly duplicate what project references already enforce.

**Smallest fix:**
- Reword the claim to "the breaks we tried".
- Add four rules: namespace must match folder; no folder or type named for a bucket; no types in the global namespace; README sections must be non-empty headed sections.

#### 5. The evidence behind the recommendation is thin and circular

**What is wrong:**
- [O] The trial is one run per cell. The judge uses the canon as its rubric and is the same model family. The same author built the system, wrote the canon and designed the trial (Hosts/OnboardingTrial/README.md:115-128).
- [O] The canon arm scored 10/10 on every task, so the scale has hit its ceiling (Hosts/OnboardingTrial/README.md:82-87).
- [O] There is no adoption by another team (README.md:84).
- [O] The seven-month case study is "in preparation" (README.md:88-89).
- [O] The rules cite a private repository, `RikhoKorp/NomadGameEngineV2` (__Docs/README.md:135-137), and I could not inspect it.
- [U] Whether the method improves onboarding time, defect rates or review load is unknown, and the repository says so.

**Why it matters:** [I] An org-wide decision needs outcome evidence. What exists here is conformance-to-itself evidence.

**Smallest fix:**
- Repeat the trial with at least 5 runs per cell.
- Use a rubric that is not the canon, such as generic design-quality criteria, with a different-vendor judge and a human-graded subset.
- Publish the NGE case study, or extracts from it.

#### 6. The "reproducible" trial contaminates any repeat of itself

**What is wrong:**
- [O] The canon arm gets `git archive HEAD` of the whole repository (Hosts/OnboardingTrial/trial.sh:40).
- [O] I prepared a run and checked the canon copy. It contains `Hosts/OnboardingTrial/README.md`, which lists the three tasks and the moves the judge penalised: "CSV format ... in the Invoicing Feature", "`Money.Minus` was added to Core" (lines 99-101). It also contains `judge-prompt.md` and the judge's full verdicts in `_Trails/`.
- [O] The blind letter-to-arm map is fixed and committed (trial.sh:90).
- [O] The designer's own notes say the control code "still taught the method" through comments (Hosts/OnboardingTrial/_Trails/README.Trail.20261022.md:24-28).

**Why it matters:** [I] Any repeat run is answer-key-in-the-room. The canon arm can read what scored well. "Repeatable" (Hosts/OnboardingTrial/README.md:9) is therefore not true for any run after the first.

**Smallest fix:**
- Exclude `Hosts/OnboardingTrial/` from the canon arm's archive.
- Draw the blind map randomly per run, and store it outside the work tree until grading.

#### 7. Maturity and bus factor: one person and one AI, in two days, on an unmerged branch

**What is wrong:**
- [O] Every CODEOWNERS entry is `@RikhoDev` (.github/CODEOWNERS:6-17).
- [O] 21 of 43 commits are authored and committed by "Claude <noreply@anthropic.com>", all dated 2026-10-21 or 2026-10-22. Before that there were 22 human commits of prose (`git log`).
- [O] Everything described in the README is on `claude/serene-gates-jcd9gw`, 21 commits ahead of `main`, which still holds the 2025-2026 prose.
- [O] GitHub reports 2 stars, 0 forks and 2 open PRs, both bot-generated "problem statement mismatch" PRs.
- [O] There is no CHANGELOG, CONTRIBUTING, SECURITY file or release tag (file list: `git ls-files`).

**Why it matters:**
- [I] We would be adopting an unreleased, single-maintainer artefact whose whole enterprise layer is roughly 48 hours old, and which has not been reviewed by its own owner through a PR.
- [I] Long-term support is a real risk. A fork is cheap, though, because of the MIT licence (LICENSE:1-21).

**Smallest fix:**
- Merge through a reviewed PR.
- Tag v0.1 with a CHANGELOG.
- Name a second maintainer, or state plainly that it is a personal project.

#### 8. The tone is unprofessional for an enterprise audience, and the metaphor layer is binding

**What is wrong:**
- [O] The root README ends with "If that makes you uncomfortable, I understand if you'd rather not proceed" and "keep the fire burning. 🔥" (README.md:116-132).
- [O] The Worldview calls the method "a cultural operating system" and "a rhythm of becoming" (Worldview.md:10-13). It defines a "Shaman" role (Worldview.md:84-90), and Hosts are "the tent where the compass is kept" (Worldview.md:96).
- [O] Chronicles tell of "The First Shaman" and "Spirits" (__Docs/_Chronicles/2511-02-The-First-Shaman-Chronicle.md:8-23).
- [O] Translation.md ends with an emoji (line 56).
- [O] The Worldview is one of the four canon (binding) files (__Docs/README.md:17; .nomad-method/canon:4).

**Why it matters:** [I] An engineering standard that binds people to metaphor creates disputes about meaning, and it will not survive a procurement or architecture-board review. It also undercuts the strong parts.

**Smallest fix:**
- Make `Worldview.md` a non-binding guide, and keep the binding rules in Architecture.md and Evidence-And-Authority.md.
- Remove the "AI Generation" and "Closing Thought" sections, with their emoji, from the root README. Replace them with one factual provenance line.

#### 9. Core rules and key terms are defined inconsistently, even in the reference system

**What is wrong:**
- [O] The trigger for moving code into Core is stated four ways:
  - "only when common language emerges across pillars" (__Docs/Architecture.md:127; Worldview.md:76-77);
  - "language shared by more than one Feature" (Reference/Billing/Core/Core.csproj:2);
  - "earned by a second speaker" (__Docs/Translation.md:19);
  - the reference system's own example, which promoted `Money` because a second Feature needed it (Reference/Billing/README.md:69-70).
- [O] "Two independent consumers" is never defined (__Docs/Architecture.md:130). The DocReader README calls two same-author consumers "weak evidence" (Hosts/DocReader/README.md:46-50), and Billing's two "independent" consumers were written by the same AI on the same day.
- [O] "Placement is narrative" (Worldview.md:30-32), and the governing test "whose meaning disappears if this artifact disappears?" (__Docs/Architecture.md:38-41) is a judgement call that no check holds.

**Why it matters:** [I] The decisions this method most wants to govern are promotion and placement. Across teams, those decisions will diverge without one definition, and reviews will turn into arguments about doctrine.

**Smallest fix:** Add one sentence to `Architecture.md#promotion` that defines "independent consumer" and the Core trigger. Align `Core.csproj` and `Translation.md` with it.

#### 10. The reference system is not "enterprise", and the scaling story is unshown

**What is wrong:**
- [O] All Features compile into one `Features.csproj` (Reference/Billing/Billing.sln:6), and the adoption guide prescribes "one project per pillar" (__Docs/Adoption.md:81). Feature boundaries are therefore namespace conventions inside one assembly.
- [O] `JsonFileInvoiceStore` says it lets "several Hosts on one machine share" invoices (JsonFileInvoiceStore.cs:8). It locks only within one process (lines 16, 26-36), and its `Add` reads, modifies and writes the file (lines 28-35).
- [I] Two writing processes would therefore lose updates.
- [O] By default the Api uses memory and the Worker uses a file (Hosts/Api/Program.cs:11-14 and Hosts/Worker/Program.cs:11), so out of the box they share nothing. Reference/Billing/README.md:26 says they share a file.
- [O] Tooling exists only for .NET, PowerShell and bash. Java and TypeScript get one sentence (__Docs/Adoption.md:85-86). Level 4 depends on a single-vendor plugin for Claude Code (README.md:54-57; __Docs/Adoption.md:106-114).

**Why it matters:**
- [I] With 400 engineers, the questions are many repos, many languages, many Features and vendor-neutral assistants. None of these is shown.
- [I] Showing a race-prone store as "what the rules look like in an enterprise codebase" (Reference/Billing/README.md:11) invites copy-paste.

**Smallest fix:**
- Label the file store as a demonstration and make both Hosts default to the same store.
- Add one paragraph, or an example, on multi-assembly Features and the polyglot path.
- State the plugin as optional and Claude-specific.

#### Also noted (minor)

- [O] The Billing pillar table is split by a blank line, so the Core row renders as stray text (Reference/Billing/README.md:27-28).
- [O] The root README says `explain` reports "who owns it, and where it came from" (README.md:52-53). For a code file, `explain` printed only the pillar, the world and the owning README, with no person and no lineage.
- [O] The trial's `session()` prints its exit code after a subshell under `set -e`, so a failing session aborts that worker rather than recording `exit=N` (trial.sh:3, 78-80).
- [O] The canon-authority check fails on 13 historical canon commits when run over the full history. This is expected, because the check is retroactive, but it means the audit trail starts on 2026-10-22.

### 5. What I ran, and what happened

| Item | Command | Result |
|---|---|---|
| Reference tests | `dotnet test Reference/Billing/Billing.sln --configuration Release` | [O] **Passed 24/24** in about 11.5 s. |
| Conformance evasion | 3 new code files and a 1-line README in a scratch copy (weakness 4) | [O] **24/24 still passed.** The repository check flagged only the missing status header. |
| Repository check | `pwsh Scripts/Test-Repository.ps1` | [O] **Passed** in about 14 s: "55 Markdown files, 4 canon files". All 44 PowerShell proof assertions printed ok. |
| Canon authority, recent | `Test-CanonAuthority.ps1 -Range 4bd3677~1..HEAD` | [O] Passed, 4 commits. |
| Canon authority, full history | same check, range from the root commit to HEAD | [O] **Failed**: 13 canon commits declare no authority. |
| Canon authority, spoof | bot-authored commit, trailer `Canon-Authority: human` (weakness 1) | [O] **Passed.** |
| Canon authority, neuter | check replaced by `exit 0`, no trailer (weakness 3) | [O] **Passed.** |
| DocReader tour | `reader.ps1` | [O] Clean tour of the DocReader's own pillars. |
| DocReader canon | `reader.ps1 canon` | [O] Lists the 4 canon files and the 8 assistant-decided sections. |
| DocReader explain | `reader.ps1 explain Reference/Billing/Features/Reminders/_Connectors/OutstandingFromInvoicing.cs` | [O] Pillar, world and owning README with its promise. It does not say this file is a connector. |
| DocReader trail | `reader.ps1 trail Worldview.md` | [O] Three Trails. |
| DocReader errors | `explain nonexistent`; `explain` with no path | [O] Exit 1 and exit 2, as documented. |
| OnboardingTrial prepare | `bash Hosts/OnboardingTrial/trial.sh prepare ../trialwork` | [O] Six copies; canon baselines 24 tests, control 18; about 53 s. |
| OnboardingTrial grade (dry run) | `bash Hosts/OnboardingTrial/trial.sh grade ../trialwork` | [O] Five conformance rules passed on every copy; six empty diffs; judge folder built; about 76 s. |
| OnboardingTrial run | `trial.sh run` | Not executed: it launches six headless Claude sessions. [U] I did not reproduce the pilot's scores. |
| GitHub | `gh api` on the repository (read-only) | [O] `main` is not protected; no rulesets; CI green on the last five branch commits; 2 stars, 0 forks. |

[O] The trial's own record notes that `pwsh` was not installed for the pilot sessions, so no canon-arm session ran the documents check (Hosts/OnboardingTrial/_Trails/README.Trail.20261022.md:37-40).

### 6. Evidence I would need before rolling it out to ten teams

1. **Outcome data from our own pilot**, against a comparable team over the same period:
   - architecture violations caught in CI vs. found in review or production;
   - review time per AI-heavy PR;
   - time to first merged PR for new joiners;
   - defect and rollback rates;
   - engineer hours spent on the method;
   - a developer survey on friction.
2. **Governance that cannot be forged**, demonstrated:
   - branch protection and required code-owner review are on;
   - `Canon-Authority: human` is verified against signed commits or PR approvals;
   - the checks cannot be disabled by the commits they check;
   - a red-team pass in which an agent tries to spoof authority and fails.
3. **Hardened conformance checks:** our engineers, and an adversarial AI, try at least 20 deliberate breaks in our stack. We report the catch rate and the false-positive rate on real code.
4. **A repeated, uncontaminated trial:**
   - at least 5 runs per cell;
   - tasks taken from our codebase;
   - a rubric that is not the canon;
   - a judge from a different vendor, plus a blinded human-graded sample;
   - the trial folder removed from the canon arm.
5. **Polyglot proof:** the Level 3 pattern working in at least one of our non-.NET stacks (ArchUnit or dependency-cruiser), and across separate repositories or assemblies per Feature.
6. **Compliance sign-off:** our audit and risk function confirms that `origin`, `decided_by_assistant` and Trails meet whatever AI-provenance requirements we have. They must also accept, or redact, verbatim AI transcripts kept in the repository, which carry data-retention and IP risk.
7. **An owner on our side:** a sustainability plan with an internal fork, named maintainers, versioned releases, and a human-ratified canon in which no binding section is AI-decided and unread.
8. **The external case study** (NGE, seven months), with numbers, from a team other than the author's, if possible.
