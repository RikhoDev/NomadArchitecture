---
status: non-canon
kind: guide
origin: ai
---

# Practitioner guide

The day-to-day, task by task. Each answer points to the canon rule it
applies; this guide adds no rules.

## Starting work with an AI assistant

Point it at [`AGENTS.md`](../AGENTS.md); most assistants read it on their own.
With Claude Code, install [nomad-method](https://github.com/RikhoDev/nomad-method)
so that the working discipline is loaded at the start of each session. Ask for
an analysis before a change. When the assistant proposes something, read the
proposal; "proceed" authorizes that proposal and nothing beyond it
([Delegation](Evidence-And-Authority.md#delegation)).

## "Where does this file go?"

Ask whose meaning would disappear if the file did, and put it with that owner
([Placement](Architecture.md#placement)). If a tool requires a name, such as
`tests/` or `skills/`, keep that name
([Required by the platform](Architecture.md#required-by-the-platform)). To see
how the repository reads an existing path:

```text
pwsh Hosts/DocReader/reader.ps1 explain <path>
```

## Adding a capability

1. **Is it a new promise?** Then it is a new Feature, as `Reminders` is in
   [Billing](../Reference/Billing/README.md). If it serves an existing
   promise, it belongs inside that Feature.
2. **Put the public promise at the Feature root.** If the Feature needs
   something it does not own, declare that need as a contract there
   ([Contracts and connectors](Architecture.md#contracts-and-connectors)).
3. **Fulfil the need with a Foundation, or with a connector in `_Connectors/`**
   when it comes from another Feature. A connector holds no policy.
4. **Write its README answering Promise, Residents, Relationships, Proof and
   Status** ([Feature README](Architecture.md#feature-readme)). Keep its tests
   in `_Tests/` beside it.
5. **Run the conformance tests.** They fail if the new code reaches where it
   should not.

## Two places need the same thing

Wait for the second real consumer, then promote, one step up the ladder
([Promotion](Architecture.md#promotion)). Make the move a commit of its own,
with nothing else changed, and extend the code in the next commit. Billing's
`Money` shows what happens otherwise: its move and its extension shared a
commit, so `git log --follow` loses its history without `-M30%`.

## Changing a rule

1. **Search the canon** for an existing rule, and amend that rather than add
   ([How canon grows](README.md#how-canon-grows)).
2. **Say what the change replaces or removes,** in the document and in the
   commit message.
3. **Open a Trail for the change,** `_Trails/Canon-<Topic>.Trail.<YYYYMMDD>.md`.
4. **Declare the authority** in the commit's last paragraph:

   ```text
   Canon-Authority: review
   Co-Authored-By: <assistant, if one drafted it>
   ```

   Use `human` if you are a canon owner and wrote or read the rule yourself.
   Use `delegated` with a `Delegation: "<words>"` line when an assistant
   decided under your delegation.
5. **Open a pull request.** A canon owner approves it, or it does not merge
   ([Authority](Evidence-And-Authority.md#authority)).

## Reading what an assistant decided

`pwsh Hosts/DocReader/reader.ps1 canon` lists the sections an assistant
decided under delegation. When you have read one and agree, remove its name
from the file's `decided_by_assistant` header, in a commit declared
`Canon-Authority: human`. The decision stays in its Trail.

## Disagreeing

Request changes on the pull request. The canon does not change while canon
owners disagree; write the open question into the change's Trail
([When owners disagree](Evidence-And-Authority.md#when-owners-disagree)).

## Saying what you know

When you report, label each claim as observed (with where you saw it),
interpreted, or unknown. A search that finds nothing proves only that this
search found nothing ([Claims](Evidence-And-Authority.md#claims)).
