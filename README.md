# 💎 LazosTech DAO: Institutional Governance Protocol
**Modular Governance Infrastructure built for ETHGlobal HackMoney 2026**

---

## 🏗️ The Vision: A Scalable "Roadmap" for Governance
LazosTech is not just a voting tool; it is a **modular infrastructure** designed as a "blockchain highway." For this hackathon, we built the **LazosTech DAO**, a specialized governance engine running on top of our **EIP-2535 Diamond Standard** core.

This architecture allows institutional entities (Universities, Tech Hubs, Corporate Boards) to deploy upgradeable governance logic without migrations, ensuring that as the organization grows, the "highway" stays intact while new "vehicles" (facets) can be added.

## 🏛️ The Demo: Zonamerica Board Meeting
To demonstrate the power of our DAO, we simulated a high-stakes institutional scenario:
**The Zonamerica Board of Directors deciding on the construction of the "Ethereum Building" within their Free Trade Zone in Cali, Colombia.**

### The On-Chain Governance Cycle:
Using our automated engine, we executed a complete lifecycle of **15 verifiable transactions** on **Base Sepolia**, covering:
1. **Board Formation:** Initializing the DAO and authorized board members.
2. **Session Opening:** Launching the "Zonamerica Hub Expansion" session.
3. **Strategic Resolutions:** Proposing 4 critical binary decisions:
   - *Is construction viable in the current zone?*
   - *Is the required land available?*
   - *Does the project align with Zonamerica’s 2030 goals?*
   - *Final approval for the "Ethereum Building" project.*
4. **Automated Consensus:** Executing the voting process and finalizing results on-chain.



---

## 🛠️ Technical Stack & Implementation

### 💎 The "Highway" (EIP-2535 Diamond)
We chose the **Diamond Standard** to overcome the 24KB contract limit and provide a future-proof structure. 
- **Diamond Proxy:** `0xd225CBF92DC4a0A9512094B215b7b4Df2870DeE8`
- **Modular Facets:** Logic is decoupled from storage, allowing us to swap the `DaoEthGlobalFacet` if governance rules change.
- **AppStorage Pattern:** We implemented a centralized storage pointer to maintain state consistency across the entire Diamond.

### ⛓️ The Execution (Base Sepolia)
- **Framework:** Foundry.
- **On-Chain Proof:** All 15 transactions were executed via `script/ethglobal/DemoRun.s.sol`.
- **Transparency:** Every board decision is anchored on Base, providing a public, immutable audit trail for the university and board members.

---

## 📂 Repository Structure
- **/src/facets/dao-ethglobal**: Core logic for the DAO MVP.
- **/src/libraries/AppStorage.sol**: The "Source of Truth" for the Diamond state.
- **/script/ethglobal**: Deployment and Demo scripts that triggered the 15 txs.
- **/broadcast**: Real-world transaction receipts (Base Sepolia).
- **/ethglobal-frontend**: A streamlined, single-purpose interface to visualize the board's resolutions.

## 🏁 How to Verify the Demo
1. Check the **`broadcast/`** folder to see the JSON receipts of the transactions.
2. Visit **BaseScan** using the Diamond Proxy address to see the governance events in real-time.
3. Review **`src/facets/dao-ethglobal/DaoEthGlobalFacet.sol`** to understand how we handled the Zonamerica board logic.

---
*LazosTech is the foundation for verifiable institutional trust. Built with passion for ETHGlobal 2026.*
