// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "src/libraries/AppStorage.sol";
import {ITicketsModule} from "src/interfaces/modules/ITicketsModule.sol";

contract TicketsFacet is ITicketsModule {
    event TicketsMinted(address indexed to, uint256 amount, uint256 indexed ticketType, address operator);
    event TicketsTransferred(address indexed from, address indexed to, uint256 amount);
    event TicketsUsed(address indexed user, uint256 amount);
    event TicketsRedeemed(address indexed user, uint256 tickets, uint256 nudosSpent);

    // ----------------------------
    // REDEEM NUDOS FOR TICKET
    // ----------------------------
    function redeemTickets(uint256 ticketsAmount) external {
        AppStorage.Layout storage s = AppStorage.layout();
        uint256 requiredNudos = ticketsAmount * s.nudosPerTicket;
        require(s.nudosBalance[msg.sender] >= requiredNudos, "Insufficient NUDOS");

        // Descontar NUDOS
        s.nudosBalance[msg.sender] -= requiredNudos;

        // Agregar tickets
        s.ticketBalance[msg.sender] += ticketsAmount;

        emit TicketsRedeemed(msg.sender, ticketsAmount, requiredNudos);
    }

    // ----------------------------
    // MINT TICKET (cumple con ITicketsModule)
    // ----------------------------
    function mintTicket(address to, uint256 ticketType, uint256 amount) external override {
        AppStorage.Layout storage s = AppStorage.layout();
        require(s.isUniversityStaff[msg.sender], "Only university staff");
        require(amount > 0, "Invalid amount");

        s.ticketBalance[to] += amount;
        emit TicketsMinted(to, amount, ticketType, msg.sender);
    }

    // ----------------------------
    // TRANSFER TICKET (cumple con ITicketsModule)
    // ----------------------------
    function transferTicket(address from, address to, uint256 ticketId) external override {
        AppStorage.Layout storage s = AppStorage.layout();
        require(msg.sender == from, "Not owner");
        require(s.ticketBalance[from] >= ticketId, "Insufficient tickets");

        s.ticketBalance[from] -= ticketId;
        s.ticketBalance[to] += ticketId;

        emit TicketsTransferred(from, to, ticketId);
    }

    // ----------------------------
    // USE TICKET (cumple con ITicketsModule)
    // ----------------------------
    function useTicket(uint256 ticketId) external override {
        AppStorage.Layout storage s = AppStorage.layout();
        require(s.ticketBalance[msg.sender] >= ticketId, "Insufficient tickets");

        s.ticketBalance[msg.sender] -= ticketId;
        emit TicketsUsed(msg.sender, ticketId);
    }

    // ----------------------------
    // VIEW FUNCTION
    // ----------------------------
    function getTickets(address user) external view returns (uint256) {
        return AppStorage.layout().ticketBalance[user];
    }
}
