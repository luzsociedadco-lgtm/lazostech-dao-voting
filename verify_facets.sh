#!/bin/bash

FACETS=(
"0xF7A32c99401EdEFf07B86B4E0525da6a90664d3e NudosCore src/core/NudosCore.sol:NudosCore"
"0x.... MarketFacet src/facets/MarketplaceFacet.sol:MarketplaceFacet"
"0x.... RewardFacet src/facets/RewardFacet.sol:RewardFacet"
"0x.... TicketsFacet src/facets/TicketsFacet.sol:TicketsFacet"
"0x.... UniversityFacet src/facets/UniversityFacet.sol:UniversityFacet"
"0x.... DaoFacet src/facets/DaoFacet.sol:DaoFacet"
)

CHAIN_ID=84532

for entry in "${FACETS[@]}"; do
    ADDRESS=$(echo $entry | awk '{print $1}')
    NAME=$(echo $entry | awk '{print $2}')
    PATH=$(echo $entry | awk '{print $3}')

    echo "🚀 Verifying $NAME at $ADDRESS"
    
    forge verify-contract \
      --chain-id $CHAIN_ID \
      --num-of-optimizations 200 \
      --watch \
      $ADDRESS \
      $PATH \
      --etherscan-api-key $ETHERSCAN_API_KEY
done
