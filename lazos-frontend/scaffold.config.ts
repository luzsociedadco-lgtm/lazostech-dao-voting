import * as chains from "viem/chains";

export const DEFAULT_ALCHEMY_API_KEY = process.env.NEXT_PUBLIC_ALCHEMY_API_KEY || "";

const scaffoldConfig = {
  // 👇 Red en la que estás trabajando
  targetNetworks: [chains.baseSepolia],

  // 👇 Intervalo de actualización de datos (en milisegundos)
  pollingInterval: 30000,

  // 👇 Tu API Key de Alchemy
  alchemyApiKey: DEFAULT_ALCHEMY_API_KEY,

  // 👇 Tu RPC personalizado (el que pusiste en .env.local)
  rpcOverrides: {
    [chains.baseSepolia.id]: process.env.NEXT_PUBLIC_RPC_URL || "",
  },

  // 👇 Si usas WalletConnect
  walletConnectProjectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || "",

  // 👇 Para usar solo burner wallet local (opcional)
  onlyLocalBurnerWallet: false,
} as const;

export default scaffoldConfig;
