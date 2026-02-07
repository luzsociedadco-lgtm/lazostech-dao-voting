'use client'

import { WagmiProvider, createConfig, http } from 'wagmi'
import { mainnet, polygon, sepolia } from 'wagmi/chains'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'

const config = createConfig({
  ssr: false,  // 👈 ARREGLA EL ERROR DE indexedDB
  chains: [mainnet, polygon, sepolia],
  transports: {
    [mainnet.id]: http(),
    [polygon.id]: http(),
    [sepolia.id]: http(),
  },
})

const queryClient = new QueryClient()

export function WagmiWrapper({ children }: { children: React.ReactNode }) {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        {children}
      </QueryClientProvider>
    </WagmiProvider>
  )
}