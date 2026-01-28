# _Ports & _Connectors  
### Mechanical Boundaries & Integration Surfaces in NomadArchitecture

---

## 1. Purpose of This Document

This chapter teaches the architectural role of `_Ports` and `_Connectors` in NomadArchitecture.  
It is written for:

- newcomers learning the system  
- engineers implementing Features  
- architects designing new tribes  
- Hosts integrating Features into environments  
- reviewers enforcing Nomad invariants  

It explains:

- what `_Ports` are  
- what `_Connectors` are  
- how they relate  
- how they preserve autonomy  
- how they enable portability  
- how they support override safety  
- how they integrate with Hosts and Foundations  

This is **law**, **learning material**, and **onboarding guidance**.

---

## 2. Why `_Ports` and `_Connectors` Exist

NomadArchitecture is built on three pillars:

- **Features express meaning**  
- **Foundations provide mechanics**  
- **Hosts orchestrate**  

But Features still need to:

- access tools  
- store state  
- interact with the world  
- expose capabilities  
- integrate with UI, network, or runtime  

They must do this **without contaminating their meaning** and **without depending on any environment**.

This is the tension `_Ports` and `_Connectors` solve.

---

## 3. `_Ports` - The Feature's Mechanical Boundary

### 3.1 Definition

`_Ports` define **what the Feature needs mechanically**.

They are:

- pure interfaces  
- pure contracts  
- pure abstractions  
- owned by the Feature  
- stable and environment-agnostic  

They express the **mechanical dialect** of the Feature.

### 3.2 What belongs in `_Ports`

- memory dialect contracts  
- tool interfaces  
- policy interfaces  
- model binding contracts  
- capability interfaces  
- mechanical boundaries  

### 3.3 What does *not* belong

- logic  
- implementations  
- environment assumptions  
- infrastructure references  
- Host knowledge  
- UI or network code  

### 3.4 Why `_Ports` matter

They give Features:

- **autonomy**  
- **portability**  
- **testability**  
- **override safety**  
- **mechanical clarity**  

A Feature depends only on its own `_Ports`, never on external mechanics.

---

## 4. `_Connectors` - The Feature's Integration Surface

### 4.1 Definition

`_Connectors` contain everything that allows the Feature to **plug into the world**.

They are the Feature's **integration layer**, including:

- default implementations of `_Ports`  
- adapters to Foundations  
- adapters to Hosts  
- adapters to external systems  
- UI bindings  
- protocol bindings  
- environment-specific glue  
- mocks and test doubles  
- identity manifests  

### 4.2 What belongs in `_Connectors`

- default memory dialects  
- default tools  
- default policies  
- HTTP route maps  
- CLI bindings  
- Angular services  
- Web components  
- Node/Express adapters  
- gRPC bindings  
- Kafka topic bindings  
- test mocks  
- local infrastructure adapters  
- identity manifests (e.g., `Feature.json`)  

### 4.3 What does *not* belong

- domain logic  
- Feature meaning  
- cross-Feature knowledge  
- Host orchestration  
- environment secrets  

### 4.4 Why `_Connectors` matter

They give Features:

- **self-sufficiency**  
- **predictable defaults**  
- **environment independence**  
- **clean integration**  
- **testability**  
- **override safety**  

---

## 5. The Relationship Between `_Ports` and `_Connectors`

### 5.1 `_Ports` define the contract  

â€œWhat the Feature needs mechanically.â€

### 5.2 `_Connectors` provide the integration surface  

â€œHow the Feature plugs into the world.â€

### 5.3 Features depend only on `_Ports`  

Never on `_Connectors`.

### 5.4 Hosts override `_Connectors`  

Never `_Ports`.

### 5.5 Foundations provide fallback mechanics  

If neither the Feature nor the Host provides an implementation.

This ensures:

- autonomy  
- override safety  
- environment independence  
- predictable wiring  

---

## 6. The Three-Tier Wiring Model

NomadArchitecture uses a deterministic fallback model:

### Tier 1 - Host Overrides  

The Host may override any `_Connector` implementation.

### Tier 2 - Feature `_Connectors` Defaults  

If the Host does not override, the Feature's defaults are used.

### Tier 3 - Foundations  

If neither the Host nor the Feature provides an implementation, Foundations supply the fallback.

This ensures:

- autonomy  
- override safety  
- environment independence  
- predictable wiring  

---

## 7. Examples

### 7.1 Movement Feature

```text
_Ports/
  IMovementIntegrator.cs
  IMovementPolicy.cs

_Connectors/
  LocalMovementIntegrator.cs
  LocalMovementPolicy.cs
  Movement.http.map.cs
```

### 7.2 Rendering Feature

```text
_Ports/
  ISpriteLoader.cs
  IRenderQueue.cs

_Connectors/
  LocalSpriteLoader.cs
  WebGLSpriteLoader.cs
  DotNetMinimalApiRoutes.cs
```

### 7.3 Actor Feature

```text
_Ports/
  IActorEnvelopeBuilder.cs

_Connectors/
  LocalEnvelopeBuilder.cs
  Actor.json
  AngularActorService.ts
```

---

## 8. Anti-Patterns

- Host wiring inside Features  
- Features referencing infrastructure  
- UI code inside Features  
- Features depending on Foundations directly  
- Hidden dependencies  
- Implicit wiring  
- Port explosion  
- Connectors containing domain logic  

---

## 9. Invariants

- `_Ports` are contracts  
- `_Connectors` are integration surfaces  
- Features depend only on `_Ports`  
- Hosts override only `_Connectors`  
- Foundations provide fallback mechanics  
- No domain logic in `_Connectors`  
- No environment assumptions in `_Ports`  
- No cross-Feature contamination  

---

## 10. Summary

`_Ports` and `_Connectors` are structural primitives that:

- preserve Feature autonomy  
- enforce separation of meaning and mechanics  
- enable environment-agnostic design  
- support override safety  
- maintain clarity and ceremony  
- provide predictable integration  
- keep Hosts thin  
- keep Features portable  

They are essential to NomadArchitecture's cognitive clarity and mechanical discipline.
