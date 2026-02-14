# NomadArchitecture – Mirage of Event Trails

> **Shaman's notes**: After a conversation about how collocation in same file or folder is important in NomadArchitecture, we arrived at a concensus and took the Events a feature could fire as example. Then came another discussion about how Events could be global while still discoverable and how we can make sure a developer knows what Event is consumed by what piece of code at anytime. That's a noble fight, I believe, and one that is neither easy nor certain. Here are the ideas that stemmed from that discussion.
>
> **Prompt**: Nice ideas indeed. Now, based on https://github.com/RikhoDev/NomadArchitecture/tree/main/__Docs/_Mirages and its contents, what can you come up with, in order to commit a new mirage about what we just discussed? Make it as enticing and capable as possible for other to take the trail and follow the guide.

**Copilot's Reply**:

Perfect — let’s draft a new **Mirage** that captures the essence of our discussion on **event collocation, discoverability, and consumer trails**. A Mirage in NomadArchitecture is not just documentation; it’s a **guidepost artifact** that entices others to follow the trail, showing both principle and practice.  

Here’s a proposed Mirage you could commit under `__Docs/_Mirages/EventTrail.md`:

---

## 🌌 Mirage Premise
Events are not whispers in the void. They are contracts, lineage markers, and convoy signals. In NomadArchitecture, their placement and discoverability must scream intent while guiding developers to the exact consumers that carry their lifeforce forward.

---

## 🪢 Law of Dual Identity
- **Collocation for lineage**: Events live with their origin when their lifeforce is inseparable.  
- **Root exposure for portability**: Broadly consumed events must also be exposed as screaming contract files at the feature root.  
- **No buckets**: Never hide events in abstract folders (`Events/`, `Handlers/`). Each artifact must scream its role.

---

## 🧭 Trail of Discoverability
Every event must carry a **Trail** that maps its consumers:
- **Producer**: The artifact that emits the event.  
- **Consumers**: Explicit screaming artifacts (`ConsumesX.cs`) in their respective features.  
- **Execution Map**: README.md lists all consumers, ensuring no hidden subscriptions.  
- **Telemetry**: Traces show when and how consumers fire, closing the loop between code and lineage.

---

## 🧩 Example – PaymentSucceeded
```
Features/
  Payment/
    InitiatePayment.cs       # collocated definition of PaymentSucceeded
    PaymentEvents.cs         # root contract exposure
    README.md                # Trail: lists consumers
    _Contracts/
    _Connectors/

  Notifications/
    ConsumesPaymentSucceeded.cs
    README.md

  LedgerAudit/
    ConsumesPaymentSucceeded.cs
    README.md
```

### InitiatePayment.cs
```csharp
public record PaymentSucceeded(string TransactionId) : IPaymentEvent;
```

### PaymentEvents.cs
```csharp
// Root contract exposure for portability
public record PaymentSucceeded(string TransactionId) : IPaymentEvent;
```

### Payment README.md
```markdown
## Events
- **PaymentSucceeded**
  - Produced by: InitiatePayment
  - Consumers:
    - Notifications/ConsumesPaymentSucceeded
    - LedgerAudit/ConsumesPaymentSucceeded
```

---

## ⚡ Mirage Guidance
- **Follow the Trail**: Start at the event definition → check the README → jump to screaming consumer artifacts.  
- **Never get lost**: The repo itself is the map. Trails are structural invariants, enforced by Nomad Linter.  
- **Cultural lifeforce**: Events are convoy signals. Their Trails are campfire stories that show how the tribe moves together.

---

## 🌠 Transmission
This Mirage teaches that events are not just contracts — they are **discoverable trails**. By collocating definitions, exposing root contracts, and mapping consumers, NomadArchitecture ensures developers can always trace the lifeforce of an event through its execution tree.

---

**Commit message suggestion:**
```
docs(__Docs/_Mirages): add Mirage of Event Trails
- Defines law of dual identity for events
- Introduces discoverability trail (producer, consumers, execution map)
- Provides PaymentSucceeded example with collocation + root exposure
```

---

This Mirage would entice others because it’s both **principled** (law of dual identity, no buckets) and **practical** (clear example, trail mapping, commit message). It gives them a **guide to follow** and a **pattern to replicate** in their own features.  

Would you like me to also sketch the **Nomad Linter rule** that enforces this Mirage (e.g., “every event must be listed in its producer README with consumers”), so the Mirage isn’t just aspirational but executable law?
