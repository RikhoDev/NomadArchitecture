---
status: non-canon
kind: mirage
origin: ai
---

# Caravans

This folder contains caravan manifests. They were written for tests, but no test that reads them has been found (see the status note below).

- Each caravan manifest was a YAML file named `NomadArchitecture/Caravans/<caravan>.yaml`. The folder moved here, among the Mirages, on 2026-10-21.
- Manifests list connectors (convoys) that participate in a caravan. They were meant for automated architecture checks and tests.

> **Status (2026-10-21):** no consumer of these manifests was found. A search of NomadGameEngineV2 for `RaylibInputConvoy` and `Caravans/` (in `.cs`, `.md`, `.yaml` and its CI workflows) found nothing. Other repositories, including any earlier NomadGameEngine, were not searched. NomadGameEngineV2 also states: "V2 does not need manifests or YAML to adopt this pattern" (NGE:`Engine/__Docs/Patterns/Caravan-Pattern.md`). It is kept for lineage; the reasoning is in [README.Trail.20261021.md](../../_Trails/Canon.Trail.20261021.md).

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
