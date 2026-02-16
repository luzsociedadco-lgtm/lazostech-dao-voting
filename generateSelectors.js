import fs from "fs";
import path from "path";
import solc from "solc";

const ROOT = process.cwd();
const FACETS_DIR = path.join(ROOT, "src/facets");
const OUT_FILE = path.join(ROOT, "selectors_output.sol");

function findImports(importPath) {
    try {
        // 1️⃣ ruta absoluta desde el repo
        let fullPath = path.join(ROOT, importPath);
        if (fs.existsSync(fullPath)) {
            return { contents: fs.readFileSync(fullPath, "utf8") };
        }

        // 2️⃣ ruta desde node_modules
        let nmPath = path.join(ROOT, "node_modules", importPath);
        if (fs.existsSync(nmPath)) {
            return { contents: fs.readFileSync(nmPath, "utf8") };
        }

        // 3️⃣ 🔥 NUEVO: buscar en src/ (para imports relativos ../libraries/)
        let srcPath = path.join(ROOT, "src", importPath.replace("../", ""));
        if (fs.existsSync(srcPath)) {
            return { contents: fs.readFileSync(srcPath, "utf8") };
        }

        return { error: "File not found: " + importPath };
    } catch (err) {
        return { error: err.message };
    }
}

// 🔎 Buscar todos los .sol recursivamente
function getAllSolFiles(dir, list = []) {
    const files = fs.readdirSync(dir, { withFileTypes: true });
    for (const f of files) {
        const full = path.join(dir, f.name);
        if (f.isDirectory()) getAllSolFiles(full, list);
        else if (f.name.endsWith(".sol")) list.push(full);
    }
    return list;
}

const facetFiles = getAllSolFiles(FACETS_DIR);

let output = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

`;

for (const filePath of facetFiles) {
    const source = fs.readFileSync(filePath, "utf8");
    const contractMatch = source.match(/contract\s+(\w+)/);
    if (!contractMatch) continue;

    const contractName = contractMatch[1];

    const input = {
        language: "Solidity",
        sources: {
            "Facet.sol": { content: source }
        },
        settings: {
            outputSelection: {
                "*": { "*": ["abi"] }
            }
        }
    };

    let compiled;
    try {
        compiled = JSON.parse(
            solc.compile(JSON.stringify(input), { import: findImports })
        );
    } catch {
        console.log("❌ Error compilando", contractName);
        continue;
    }

    if (!compiled.contracts?.["Facet.sol"]?.[contractName]) {
        console.log("⚠️ Saltando", contractName);
        continue;
    }

    const abi = compiled.contracts["Facet.sol"][contractName].abi;
    const functions = abi.filter(x => x.type === "function");

    output += `function get${contractName}Selectors() internal pure returns (bytes4[] memory selectors) {\n`;
    output += `    selectors = new bytes4[](${functions.length});\n`;

    functions.forEach((fn, i) => {
        output += `    selectors[${i}] = ${contractName}.${fn.name}.selector;\n`;
    });

    output += `}\n\n`;
}

fs.writeFileSync(OUT_FILE, output);
console.log("✅ Selectors generados correctamente");
