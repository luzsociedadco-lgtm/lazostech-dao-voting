import { createConfig, http } from 'wagmi'
import { getDefaultConfig } from '@rainbow-me/rainbowkit'
import { baseSepolia } from 'wagmi/chains'

const rpcUrl = process.env.NEXT_PUBLIC_RPC_URL || 'https://sepolia.base.org'

export const config = getDefaultConfig({
  appName: 'Lazos.go',
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_ID || 'default', // tu ID de WalletConnect si lo tienes
  chains: [baseSepolia],
  transports: {
    [baseSepolia.id]: http(rpcUrl),
  },
})
