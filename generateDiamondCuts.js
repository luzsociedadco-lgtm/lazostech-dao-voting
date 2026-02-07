// generateDiamondCuts.js
import fs from "fs";
import path from "path";
import solc from "solc";

const FACETS_DIR = path.join(process.cwd(), "src/facets");
const OUT_FILE = path.join(process.cwd(), "diamondCuts_output.sol");

let output = `// SPDX-License-Identifier: MIT\npragma solidity ^0.8.30;\n\n`;

// Leer todos los archivos .sol, ignorando directorios
const facetFiles = fs.readdirSync(FACETS_DIR, { withFileTypes: true })
    .filter(f => f.isFile() && f.name.endsWith(".sol"))
    .map(f => f.name);

let cutIndex = 0;
output += `IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](${facetFiles.length});\n\n`;

for (const file of facetFiles) {
    const filePath = path.join(FACETS_DIR, file);
    const source = fs.readFileSync(filePath, "utf8");

    // Detectar el nombre del contrato
    const contractMatch = source.match(/contract\s+(\w+)/);
    if (!contractMatch) continue;
    const contractName = contractMatch[1];

    // Preparar entrada para solc
    const input = {
        language: "Solidity",
        sources: { "Temp.sol": { content: source } },
        settings: { outputSelection: { "*": { "*": ["abi"] } } }
    };

    // Compilar
    let compiled;
    try {
        compiled = JSON.parse(solc.compile(JSON.stringify(input)));
    } catch (err) {
        console.warn(`⚠️  No se pudo compilar ${contractName}: ${err.message}`);
        continue;
    }

    const contract = compiled.contracts["Temp.sol"][contractName];
    if (!contract) continue;

    const abi = contract.abi;
    const functions = abi.filter(item =>
        item.type === "function" &&
        (item.stateMutability === "nonpayable" || item.stateMutability === "view" || item.stateMutability === "pure")
    );

    // Generar función de selectors para este facet
    output += `function get${contractName}Selectors() internal pure returns (bytes4[] memory selectors) {\n`;
    output += `    selectors = new bytes4[](${functions.length});\n`;
    functions.forEach((fn, idx) => {
        output += `    selectors[${idx}] = ${contractName}.${fn.name}.selector;\n`;
    });
    output += `}\n\n`;

    // Generar bloque de IDiamondCut.FacetCut
    output += `cut[${cutIndex}] = IDiamondCut.FacetCut({\n`;
    output += `    facetAddress: address(new ${contractName}()),\n`;
    output += `    action: IDiamondCut.FacetCutAction.Add,\n`;
    output += `    functionSelectors: get${contractName}Selectors()\n`;
    output += `});\n\n`;

    cutIndex++;
}

// Guardar archivo final
fs.writeFileSync(OUT_FILE, output);
console.log(`✅ DiamondCuts y selectors generados en ${OUT_FILE}`);
