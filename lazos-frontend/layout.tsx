'use client'

import { getDefaultWallets } from '@rainbow-me/rainbowkit'
import { configureChains, createClient, mainnet } from 'wagmi'
import { publicProvider } from 'wagmi/providers/public'

const { connectors } = getDefaultWallets({
  appName: 'Lazos Dapp',
  chains: [mainnet],
})

export const wagmiClient = createClient({
  autoConnect: true,
  connectors,
  provider: publicProvider(),
})
