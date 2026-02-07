// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IDAOFacet {
    function initDao() external;
    function setChairperson(address chair) external;
    function openSession(string calldata name) external;
    function addBoardMember(address member) external;
    function createResolution(string calldata description) external;
    function vote(uint256 resolutionId, bool support) external;
}

contract DemoRun is Script {

    // 👇 PEGA AQUI LA NUEVA ADDRESS DEL DEPLOY
    address constant DIAMOND = 0xd225CBF92DC4a0A9512094B215b7b4Df2870DeE8;

    address constant CHAIR = 0xCa9cDD6714033a4D08e4BE479c1077e5B35f3a4B;

    function run() external {

        vm.startBroadcast();

        IDAOFacet dao = IDAOFacet(DIAMOND);

        // 🔥 INIT STORAGE
        dao.initDao();

address chair = vm.addr(vm.envUint("PRIVATE_KEY"));

dao.setChairperson(chair);

// 🔥 EL FIX CLAVE: el chair también es board member
dao.addBoardMember(chair);

dao.addBoardMember(0x1111111111111111111111111111111111111111);
dao.addBoardMember(0x2222222222222222222222222222222222222222);
dao.addBoardMember(0x3333333333333333333333333333333333333333);


        // 🏛 abrir sesión
        dao.openSession("Ethereum Building @ Zonamerica Cali");

        // 📜 resoluciones (las 4 deliberaciones)
        dao.createResolution("Is construction viable in Zonamerica?");
        dao.createResolution("Is required land available?");
        dao.createResolution("Does the building align with Zonamerica goals?");
        dao.createResolution("Final approval for construction");

        // 🗳 votos
        dao.vote(0, true);
        dao.vote(1, true);
        dao.vote(2, true);
        dao.vote(3, true);

        vm.stopBroadcast();
    }
}
