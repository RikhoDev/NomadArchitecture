---
status: canon
kind: guide
origin: ai-assisted
---

# _Connectors
### A Feature's relationships

This guide applies
[Architecture: contracts and connectors](../../__Docs__/Architecture.md#contracts-and-connectors).
It adds no rules.

## Purpose

A connector wires a real seam between the Feature and something it does not
own: a Host's composition, another Feature, a Foundation mechanism, a tool or
a protocol. It fulfils a contract; it does not define the Feature's meaning.

## What belongs here

- the binding that registers the Feature into a Host's composition
- a bridge between this Feature and another owner, imported from both sides
- adapters to a protocol, UI framework, runtime or tool, when the Feature has
  a real need for one
- vocabulary that exists only for this relationship

## What does not belong here

- the Feature's public promise, which lives at the Feature root
- algorithms: if a connector grows one, extract a capability
- new meaning: if a connector invents some, the owning pillar is being bypassed
- speculative defaults, no-op stand-ins, or fallbacks wired "just in case"
- environment secrets

## Checklist

- [ ] Does this file wire a seam that exists today?
- [ ] Is it thin enough that its logic lives somewhere else?
- [ ] Would it disappear if this relationship disappeared?

If all answers are yes, it belongs in `_Connectors`.

## Lineage

The earlier version of this guide treated connectors as default
implementations, mocks and fallbacks, and forbade references to other
Features. That model is [superseded](../../__Docs__/Concepts/PortsAndConnectors.md);
see git history for the previous text.
