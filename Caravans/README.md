# Caravans

This folder describes the **Caravan manifest convention**.

- Each caravan manifest is a YAML file named `Caravans/<caravan>.yaml`.
- Manifests list connectors (convoys) that participate in a caravan and are used by automated architecture checks and tests.
- This repo may contain *minimal examples* of caravan manifests.
- Repo-specific caravan manifests (fixtures for a particular codebase) should live in the repo that consumes them (typically under `tests/Caravans/`).

When adding a connector that declares a `caravan: <name>` value, add or update the matching caravan manifest so tests can validate it. Prefer placing that manifest next to the tests that validate it.

Example:

```yaml
name: gameplay
summary: Caravan manifest for gameplay-related convoys
connectors:
  - connector: ExampleGameplayInputConvoy
README: |
  Minimal caravan manifest used by tests and examples.
```
