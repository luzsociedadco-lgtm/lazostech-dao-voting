// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AppStorage} from "src/libraries/AppStorage.sol";

contract MarketplaceFacet {
    using AppStorage for AppStorage.Layout;

    event ItemCreated(uint256 indexed itemId, address indexed owner, uint8 itemType, uint256 price);
    event ItemListed(uint256 indexed itemId, uint256 price);
    event ItemSold(uint256 indexed itemId, address indexed buyer, uint256 price);
    event TradeProposed(uint256 indexed tradeId, uint256 itemA, uint256 itemB, address proposer);
    event TradeAccepted(uint256 indexed tradeId, address accepter);

    function createItem(uint8 itemType, string calldata metadataURI, uint256 price) external returns (uint256) {
        AppStorage.Layout storage s = AppStorage.layout();
        uint256 id = ++s.nextItemId;

        s.items[id] = AppStorage.Item({
            id: id,
            owner: msg.sender,
            itemType: itemType,
            metadataURI: metadataURI,
            price: price,
            status: AppStorage.ItemStatus.Unlisted
        });

        emit ItemCreated(id, msg.sender, itemType, price);
        return id;
    }

    function listItem(uint256 itemId, uint256 price) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Item storage it = s.items[itemId];

        require(it.owner == msg.sender, "Not owner");

        it.price = price;
        it.status = AppStorage.ItemStatus.Listed;

        emit ItemListed(itemId, price);
    }

    function buyWithTokens(uint256 itemId) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Item storage it = s.items[itemId];

        require(it.status == AppStorage.ItemStatus.Listed, "Not for sale");

        uint256 price = it.price;
        it.owner = msg.sender;
        it.status = AppStorage.ItemStatus.Sold;

        emit ItemSold(itemId, msg.sender, price);
    }

    function proposeTrade(uint256 itemA, uint256 itemB) external returns (uint256) {
        AppStorage.Layout storage s = AppStorage.layout();
        require(s.items[itemA].owner == msg.sender, "Not owner of itemA");

        uint256 id = ++s.nextTradeId;
        s.trades[id] = AppStorage.Trade({id: id, proposer: msg.sender, itemA: itemA, itemB: itemB, accepted: false});

        emit TradeProposed(id, itemA, itemB, msg.sender);
        return id;
    }

    function acceptTrade(uint256 tradeId) external {
        AppStorage.Layout storage s = AppStorage.layout();
        AppStorage.Trade storage t = s.trades[tradeId];

        require(!t.accepted, "Already accepted");
        require(s.items[t.itemB].owner == msg.sender, "Not owner of itemB");

        address ownerA = s.items[t.itemA].owner;
        address ownerB = s.items[t.itemB].owner;

        s.items[t.itemA].owner = ownerB;
        s.items[t.itemB].owner = ownerA;

        t.accepted = true;
        emit TradeAccepted(tradeId, msg.sender);
    }

    function rateItem(uint256 itemId, uint8 rating) external {
        require(rating <= 5, "Invalid rating");
        AppStorage.layout().ratings[itemId][msg.sender] = rating;
    }

    function getItem(uint256 itemId)
        external
        view
        returns (address owner, uint8 itemType, string memory metadataURI, uint256 price, uint8 status)
    {
        AppStorage.Item storage it = AppStorage.layout().items[itemId];
        return (it.owner, it.itemType, it.metadataURI, it.price, uint8(it.status));
    }
}
