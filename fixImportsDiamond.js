import fs from "fs";
import path from "path";

const ROOT_DIRS = ["src", "script"];

const replacements = [
  // CORE
  ["facets/DiamondCutFacet.sol", "facets/core/DiamondCutFacet.sol"],
  ["facets/DiamondLoupeFacet.sol", "facets/core/DiamondLoupeFacet.sol"],
  ["facets/OwnershipFacet.sol", "facets/core/OwnershipFacet.sol"],

  // ECONOMY
  ["facets/RewardFacet.sol", "facets/economy/RewardFacet.sol"],
  ["facets/TicketsFacet.sol", "facets/economy/TicketsFacet.sol"],
  ["facets/ParticipationFacet.sol", "facets/economy/ParticipationFacet.sol"],

  // RECYCLING
  ["facets/CampusFacet.sol", "facets/recycling/CampusFacet.sol"],
  ["facets/RecycleFacet.sol", "facets/recycling/RecycleFacet.sol"],
  ["facets/UniversityFacet.sol", "facets/recycling/UniversityFacet.sol"],

  // GOVERNANCE
  ["facets/DaoFacet.sol", "facets/governance/DaoFacet.sol"],

  // MARKETPLACE
  ["facets/MarketplaceFacet.sol", "facets/marketplace/MarketplaceFacet.sol"],

  // LIBRARIES depth fix
  ["../libraries/AppStorage.sol", "../../libraries/AppStorage.sol"],
  ["../libraries/LibDiamond.sol", "../../libraries/LibDiamond.sol"],
  ["../interfaces/", "../../interfaces/"]
];

function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(file => {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) results = results.concat(walk(file));
    else if (file.endsWith(".sol")) results.push(file);
  });
  return results;
}

for (const root of ROOT_DIRS) {
  const files = walk(root);

  for (const file of files) {
    let content = fs.readFileSync(file, "utf8");
    let original = content;

    replacements.forEach(([oldPath, newPath]) => {
      content = content.replaceAll(oldPath, newPath);
    });

    if (content !== original) {
      fs.writeFileSync(file, content);
      console.log("✅ Fixed:", file);
    }
  }
}

console.log("\n🎉 Imports reparados.");
