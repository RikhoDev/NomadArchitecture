# Caravans

This folder contains caravan manifests used by the repository and tests.

- Each caravan manifest is a YAML file named `NomadArchitecture/Caravans/<caravan>.yaml`.
- Manifests list connectors (convoys) that participate in a caravan and are used by automated architecture checks and tests.

When adding a connector that declares a `caravan: <name>` value, add or update the matching caravan manifest so tests can validate it.

Example:

```yaml
name: gameplay
summary: Caravan manifest for gameplay-related convoys used by NomadGameEngine tests
connectors:
  - connector: RaylibInputConvoy
README: |
  Minimal caravan manifest used by tests and examples.
```
