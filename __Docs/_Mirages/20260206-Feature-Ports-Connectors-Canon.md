# Mirage — Feature API Canon: Ports (Harbors) + Connectors (Boats) 🪝

**Purpose:** record the lessons we learned while practising Ports/_Connectors in this repo: make them vivid, actionable, and safe to enforce. This Mirage encodes both the stories and the rules — a compact transmission for reviewers, shamen, and tools.

---

## Opening — the short story
Ports are harbors: living contracts, canonical state, and configuration where a Feature resides. Connectors are boats: thin, documented shims that let the world visit, register, and replace implementations without hauling the Feature ashore.

This pairing prevents infrastructure or UI from leaking into business logic and makes evolution auditable and safe.

---

## Pillars (what we must defend) 🧭
- **Harbors preserve intent (Ports).** Ports are public places that declare a Feature’s identity and contract. They are discoverable, documented, and carry a stability expectation.
- **Boats enable safely (Connectors).** Connectors are intentional host-facing adapters and DI helpers; they are small by design and keep heavy logic internal to the Feature.
- **Pairing prevents leak.** A Port without a Connector invites incidental coupling; a Connector without a Port scatters intent. The pair keeps features coherent.
- **Traceable exceptions only.** When we make exceptions, they must be explicit, time-boxed, and recorded.

---

## Practical rules (short checklist) ✅
- Public types belong in **`_Contracts/`** (contracts, DTOs, state) or **`_Connectors/`** (adapters, DI helpers).
- New Ports must be accompanied by a Connector skeleton or a documented, whitelisted justification.- **Connectors may be authorized plugouts** — when hosts or other features legitimately need scoped access to internal APIs, provide that access via a dedicated connector that documents scope, owner, tests, and a whitelist/approval entry.- DI/bootstraps (e.g., `IServiceCollection` extensions) belong in Connectors.
- Internal code (algorithms, helpers) remains `internal` so implementers can refactor freely.
- Treat Ports as living: add doc comments describing stability and intended consumers.

---

## Allowed exceptions & how we make them safe 🧾
- Exceptions are allowed but must be recorded in **`.feature-public-whitelist.json`** with `path`, `reason`, `approvedBy`, and an `expiry` or `migrationPlan` field.
- Common justified exceptions: cross-feature domain types promoted to Core, serialization DTOs, tests & examples (excluded from analyzer). For each, include a simple migration plan and an owner.
- The analyzer and a reflective unit test consult the whitelist — unapproved public types flag the PR.

---

## Enforcement — tools that hold the Line 🤖
- **Roslyn analyzer**: flags public types under `src/Features/**` outside `_Contracts/`/`_Connectors/` unless whitelisted; offers code-fix guidance (move to Ports/Connectors, add suppression attribute, or add whitelist entry).
- **Reflective test**: runs in CI and asserts the codebase matches the whitelist; it fails fast on new unapproved public types.
- **Suppression attribute**: `[FeaturePublicApi(Reason = "...", ApprovedBy = "@owner")]` — allowed but rare and must appear with a whitelist entry.

---

## Migration recipes — safe paths 🛠️
- When a public type is found outside Ports/Connectors:
  1. **Assess**: is it cross-feature or host-facing? If yes, **create minimal contract** in `_Contracts/`.
  2. **Encapsulate**: make the implementation `internal` and implement the Port.
  3. **Glue**: add a Connector for DI / registration and document intent.
  4. **Test**: validate behavior through the Port and add a migration note to the whitelist if immediate promotion is necessary.

- If the type is internal-only, simply change it to `internal`, add tests covering the intended use, and remove any public visibility in a non-breaking rollout.

---

## Nomad proof & short trail (what we learned in practice) 🐾
- During the lighting editor work we discovered: calling UI libraries (ImGui) without proper backends can crash hosts — a connector-side UI shim (Raylib overlay) was safer. This is a concrete example of why implementation must be internal and host glue must live in Connectors.\
- We observed public API creep; creating `RenderingHelpers` and `HostRendering` connectors clarified ownership and made host shims trivial to audit. That migration pattern is the basis for our recipes and analyzer behavior.

---

## Quick PR checklist for reviewers 📋
- [ ] If a public type was added, is it in `_Contracts/` or `_Connectors/` and documented with stability notes?
- [ ] If not, is there a whitelist entry with a migration plan and approver listed?
- [ ] Does every new Port have a Connector skeleton or a clear plan to add it?
- [ ] Are DI registration helpers placed in `_Connectors/`?

---

## Example — Ports-as-harbors, Connectors-as-boats (minimal)
```csharp
// src/Features/Audio/_Contracts/IAudioOutput.cs
/// <summary>Stable contract: plays short sounds. Consumers: hosts and test suites.</summary>
public interface IAudioOutput { void Play(Sound s); }

// src/Features/Audio/_Connectors/AudioConnector.cs
// Thin adapter for host registration
public static class AudioConnector { public static IServiceCollection AddAudio(this IServiceCollection s) => s.AddSingleton<IAudioOutput, DefaultAudioOutput>(); }

// src/Features/Audio/Implementation/DefaultAudioOutput.cs (internal)
internal class DefaultAudioOutput : IAudioOutput { /* implementation */ }
```

---

## Closing — the Mirage as a trail
This Mirage is a short transmission of what we learned: Ports are places to live; Connectors are how we welcome the world. The canon is enforceable (analyzer + test), humane (whitelist + migration plans), and Nomad in spirit — teachable, auditable, and resilient.

---

Created-by: session: ports+connectors canon (2026-02-06) — distilled from NomadGameEngine work and reviewer exchanges

