// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @notice Interfaz mínima para permitir que el core registre el módulo
interface INudosCore {
    function registerModule(bytes32 name, address module) external;
}

/// @notice RewardModule — administra el cálculo y entrega de recompensas
contract RewardModule {
    address public core;
    address public owner;

    event RewardIssued(address indexed student, uint256 amount);

    modifier onlyCore() {
        require(msg.sender == core, "Not core");
        _;
    }

    constructor(address _core) {
        core = _core;
        owner = msg.sender;
    }

    /// 💰 función dummy para emitir recompensa — luego puedes implementarlo real
    function issueReward(address student, uint256 amount) external onlyCore {
        emit RewardIssued(student, amount);
    }

    /// 🔗 Si más adelante el Core debe actualizar address:
    function updateCore(address newCore) external {
        require(msg.sender == owner, "Not owner");
        core = newCore;
    }
}
