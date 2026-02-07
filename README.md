# 💎 LazosTech DAO: Institutional Governance Engine
**A Modular EIP-2535 Diamond Protocol for University & Corporate Governance**

Built during **ETHGlobal HackMoney 2026** • Deployed on **Base Sepolia**

---

## 📖 Overview
LazosTech DAO is a high-integrity governance infrastructure designed for real-world institutional decision-making. Unlike rigid voting contracts, LazosTech utilizes the **EIP-2535 Diamond Standard** to provide a modular, scalable, and upgradeable framework.

Our pilot focused on a university sustainability board at **Zonamerica Cali**, where strategic resolutions must be auditable, transparent, and immutable.

## 🏗️ Technical Architecture (The Diamond Advantage)
The core of the project is a **Diamond Proxy**, allowing us to bypass the 24KB contract size limit and organize logic into specialized facets:

- **`DaoEthGlobalFacet.sol`**: The heart of the governance logic (Sessions, Proposals, Voting).
- **`AppStorage Pattern`**: A centralized, collision-resistant storage system that shares state across all facets.
- **`DiamondCut & Loupe Facets`**: Standard EIP-2535 interfaces for modular upgradeability.



## 🚀 On-Chain Proof of Concept
We didn't just write code; we executed a full governance lifecycle on **Base Sepolia**. 

- **Diamond Proxy Address:** `0xd225CBF92DC4a0A9512094B215b7b4Df2870DeE8`
- **Demo Proof:** 15 consecutive on-chain transactions covering:
    1. DAO Initialization & Board Setup.
    2. Session Opening: *Board Meeting: Zonamerica Hub Expansion*.
    3. Multi-resolution submission and automated voting.
    4. Resolution finalization on-chain.

## 📂 Repository Guide
```text
├── ethglobal-frontend/   # Dedicated Single-Page Demo Interface
├── src/
│   ├── facets/           # Governance & Institutional logic
│   │   └── dao-ethglobal/# Specialized DAO logic for the Pilot
│   ├── libraries/        # LibDiamond & AppStorage core
│   └── diamond/          # EIP-2535 Proxy implementation
├── script/
│   └── ethglobal/        # DemoRun.s.sol (The 15 txs engine)
└── broadcast/            # Real transaction logs on Base Sepolia
