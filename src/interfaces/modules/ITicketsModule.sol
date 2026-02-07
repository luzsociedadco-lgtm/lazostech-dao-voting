pragma solidity ^0.8.30;
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface ITicketsModule {
    function mintTicket(address to, uint256 ticketType, uint256 amount) external;
    function transferTicket(address from, address to, uint256 ticketId) external;
    function useTicket(uint256 ticketId) external;
}
