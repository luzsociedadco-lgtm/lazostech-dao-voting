// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;





import "../interfaces/modules/ITicketsModule.sol" as X;

contract TicketsFacet is ITicketsModule {
    function mintTicket(address /*to*/, uint256 /*ticketType*/, uint256 /*amount*/) external override {
        revert("mintTicket: implement");
    }
    function transferTicket(address /*from*/, address /*to*/, uint256 /*ticketId*/) external override {
        revert("transferTicket: implement");
    }
    function useTicket(uint256 /*ticketId*/) external override {
        revert("useTicket: implement");
    }
}
