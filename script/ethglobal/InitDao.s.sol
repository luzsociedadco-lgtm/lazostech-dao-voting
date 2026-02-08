// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IDaoEthGlobal {
    function setChairperson(address) external;
    function addBoardMember(address) external;
}

contract InitDao is Script {
    // 👉 Dirección del contrato que acabas de desplegar
    address constant DAO = 0x5291B202a17BAc5BF9Ed9d5Fd32da5d333Ca42c4;

    // 👉 Direcciones demo de la junta directiva
    address constant BOARD_MEMBER_1 = address(0x1111);
    address constant BOARD_MEMBER_2 = address(0x2222);
    address constant BOARD_MEMBER_3 = address(0x3333);

    function run() external {
        vm.startBroadcast();

        IDaoEthGlobal dao = IDaoEthGlobal(DAO);

        // 1️⃣ Definir chairperson (quien abre la sesión)
        dao.setChairperson(msg.sender);

        // 2️⃣ Invitar miembros de la junta
        dao.addBoardMember(BOARD_MEMBER_1);
        dao.addBoardMember(BOARD_MEMBER_2);
        dao.addBoardMember(BOARD_MEMBER_3);

        vm.stopBroadcast();
    }
}
