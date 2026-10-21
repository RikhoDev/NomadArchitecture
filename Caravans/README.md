---
status: non-canon
kind: guide
origin: ai
---

# Caravans

This folder contains caravan manifests. They were written for tests, but no test that reads them has been found (see the status note below).

- Each caravan manifest is a YAML file named `NomadArchitecture/Caravans/<caravan>.yaml`.
- Manifests list connectors (convoys) that participate in a caravan. They were meant for automated architecture checks and tests.

> **Status (2026-10-21):** no consumer of these manifests was found. A search of NomadGameEngineV2 for `RaylibInputConvoy` and `Caravans/` (in `.cs`, `.md`, `.yaml` and its CI workflows) found nothing. Other repositories, including any earlier NomadGameEngine, were not searched. NomadGameEngineV2 also states: "V2 does not need manifests or YAML to adopt this pattern" (NGE:`Engine/__Docs/Patterns/Caravan-Pattern.md`). Whether to keep this folder is an [open decision](../__Docs__/README.md#open-decisions).

The original convention: when adding a connector that declares a `caravan: <name>` value, add or update the matching caravan manifest.

Example:

```yaml
name: gameplay
summary: Caravan manifest for gameplay-related convoys used by NomadGameEngine tests
connectors:
  - connector: RaylibInputConvoy
README: |
  Minimal caravan manifest used by tests and examples.
```
