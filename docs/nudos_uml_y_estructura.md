# NUDOS — UML profesional y Estructura de carpetas Solidity

Este documento contiene:

1. Diagrama UML (clases y relaciones) en formato técnico y profesional.
2. Diagramas de secuencia clave (reciclaje → recompensa; propuesta DAO → recompensa).
3. Estructura de carpetas recomendada para los contratos Solidity, scripts y tests.

---

## 1) UML — Diagramas de Clases y Relaciones (profesional)

> **Notas**: El UML está diseñado para auditores y desarrolladores. Muestra contratos como clases, sus funciones públicas relevantes, roles y relaciones (dependencia / composición / herencia).

```mermaid
classDiagram
    %% Core
    class NudosCore{
        +registerModule(bytes32 name, address module)
        +unregisterModule(bytes32 name)
        +getModule(bytes32 name) returns (address)
        +grantRole(bytes32 role, address account)
        +revokeRole(bytes32 role, address account)
        +pause()
        +unpause()
    }

    %% Token layer
    class NudosToken{
        +mint(address to, uint256 amount)
        +burn(address from, uint256 amount)
        +balanceOf(address) view returns (uint256)
    }

    class RewardModule{
        +setRecycleRate(MaterialType m, uint256 rate)
        +setParticipationRate(bytes32 proposalType, uint256 rate)
        +calculateRecycleReward(address actor, MaterialRecord rec) returns (uint256)
        +calculateParticipationReward(address actor, bytes32 proposalId) returns (uint256)
    }

    class RecycleRewardRules{
        +getRate(MaterialType m) view returns(uint256)
    }

    class DaoModule{
        +createProposal(bytes32 kind, string calldata meta)
        +voteProposal(bytes32 proposalId, bool support)
        +executeProposal(bytes32 proposalId)
    }

    class ParticipationRewardModule{
        +registerSubmission(bytes32 proposalId, address actor, string evidence)
        +validateCompletion(bytes32 proposalId, address actor) returns (bool)
    }

    %% Campus / University layer
    class CampusEcosystemModule{
        +createCampus(bytes32 campusId, string meta)
        +getCampus(bytes32 campusId) returns (address)
    }

    class UniversityModule{
        +registerProfile(address user, ProfileData data)
        +updateProfile(address user, ProfileData data)
        +isVerified(address user) view returns (bool)
    }

    class TicketsModule{
        +mintTicket(address to, uint256 ticketType, uint256 amount)
        +transferTicket(address from, address to, uint256 ticketId)
        +useTicket(uint256 ticketId)
    }

    class TicketsRules{
        +canTransfer(address from, address to) view returns (bool)
    }

    class CampusRecycleModule{
        +reportRecycling(address actor, MaterialRecord rec)
        +getHistory(address actor) returns (MaterialRecord[])
    }

    class MarketplaceModule{
        +createListing(address seller, ListingData data)
        +buyListing(uint256 listingId)
    }

    %% Relationships
    NudosCore <|-- NudosToken : manages
    NudosCore <|-- RewardModule : registers
    NudosCore <|-- CampusEcosystemModule : registers

    RewardModule o-- RecycleRewardRules : uses
    RewardModule o-- ParticipationRewardModule : uses
    RewardModule --> NudosToken : mints

    RewardModule <.. DaoModule : reads
    DaoModule o-- ParticipationRewardModule : delegates

    CampusEcosystemModule *-- UniversityModule : contains
    CampusEcosystemModule *-- TicketsModule : contains
    CampusEcosystemModule *-- CampusRecycleModule : contains
    CampusEcosystemModule *-- MarketplaceModule : contains

    TicketsModule o-- TicketsRules : enforces
    CampusRecycleModule ..> RewardModule : provides data to

    %% Types / Data Structures (document-only)
    class ProfileData
    class MaterialRecord
    class ListingData

```

