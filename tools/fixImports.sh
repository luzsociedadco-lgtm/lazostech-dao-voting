#!/bin/bash
set -e

RESET="\033[0m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RED="\033[1;31m"

BACKUP_DIR="backup_imports"
LOG_FILE="fiximports_$(date +%Y-%m-%d_%H-%M-%S).log"
RULES_FILE="tools/import-rules.map"

echo -e "${BLUE}=== LAZOSTECH | NUDOS — Enterprise Import Fixer ===${RESET}"

# Create rule file if missing
if [ ! -f "$RULES_FILE" ]; then
mkdir -p tools
cat << 'MAP_EOF' > "$RULES_FILE"
"import \"./IDiamondCut.sol\"" -> "import \"../interfaces/diamond/IDiamondCut.sol\""
"import \"./IDiamondLoupe.sol\"" -> "import \"../interfaces/diamond/IDiamondLoupe.sol\""

"../interfaces/INudosToken.sol" -> "../interfaces/core/INudosToken.sol"
"../interfaces/IRewardModule.sol" -> "../interfaces/modules/IRewardModule.sol"
"../interfaces/IMarketplaceModule.sol" -> "../interfaces/modules/IMarketplaceModule.sol"
"../interfaces/IUniversityModule.sol" -> "../interfaces/modules/IUniversityModule.sol"
"../interfaces/ITicketsModule.sol" -> "../interfaces/modules/ITicketsModule.sol"
"../interfaces/IRecycleModule.sol" -> "../interfaces/modules/IRecycleModule.sol"
"../interfaces/IDaoModule.sol" -> "../interfaces/modules/IDaoModule.sol"
"../interfaces/IParticipationRewardModule.sol" -> "../interfaces/modules/IParticipationRewardModule.sol"
"../interfaces/ICampusEcosystemModule.sol" -> "../interfaces/modules/ICampusEcosystemModule.sol"
"../interfaces/IDiamondCut.sol" -> "../interfaces/diamond/IDiamondCut.sol"
"../interfaces/IDiamondLoupe.sol" -> "../interfaces/diamond/IDiamondLoupe.sol"
MAP_EOF
echo -e "${YELLOW}[RULES CREATED] Default import mapping generated.${RESET}"
fi

echo -e "${GREEN}[START] Generating backup...${RESET}"
mkdir -p "$BACKUP_DIR"
cp -r src "$BACKUP_DIR/src_$(date +%s)"
echo -e "${GREEN}[BACKUP DONE]${RESET}"

echo -e "${BLUE}[PROCESSING] Applying enterprise import mapping...${RESET}"

while IFS= read -r line; do
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    FROM=$(echo "$line" | cut -d'"' -f2)
    TO=$(echo "$line" | cut -d'"' -f4)

    echo -e "${YELLOW}Replacing: $FROM → $TO${RESET}"
    grep -R "$FROM" -n src >> "$LOG_FILE" || true
    find src -type f -name "*.sol" -exec sed -i "s|$FROM|$TO|g" {} \;
done < "$RULES_FILE"

echo -e "${GREEN}=== DONE 🚀 All imports updated and logged at $LOG_FILE ===${RESET}"
