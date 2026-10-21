---
status: non-canon
kind: guide
origin: ai
---

# _Connectors
### A Feature's relationships

This guide applies
[Architecture: contracts and connectors](../Architecture.md#contracts-and-connectors).
It adds no rules.

## Purpose

A connector wires a real seam between the Feature and something it does not
own: a Host's composition, another Feature, a Foundation mechanism, a tool or
a protocol. It fulfils a contract; it does not define the Feature's meaning.

## What belongs here

- the binding that registers the Feature into a Host's composition
- a bridge between this Feature and another owner
- adapters to a protocol, UI framework, runtime or tool, when the Feature has
  a real need for one
- vocabulary that exists only for this relationship

## Checklist

- [ ] Does this file wire a seam that exists today?
- [ ] Is it thin enough that its logic lives somewhere else?
- [ ] Would it disappear if this relationship disappeared?

If all answers are yes, it belongs in `_Connectors`.

## Lineage

The earlier version of this guide treated connectors as default
implementations, mocks and fallbacks, and forbade references to other
Features. That model is [superseded](PortsAndConnectors.md);
see git history for the previous text.
