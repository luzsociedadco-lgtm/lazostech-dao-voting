'use client'

import { useEffect, useState } from 'react'
import { getContract } from '@/config/ethers'
import { useAccount, usePublicClient } from 'wagmi'
import { formatUnits } from 'viem'
import { NUDOS_CONTRACT } from '../../src/config/contracts'

export default function NudosBalance() {
  const { address, isConnected } = useAccount()
  const publicClient = usePublicClient()
  const [balance, setBalance] = useState<string | null>("0")
  const [symbol, setSymbol] = useState<string>('NUDOS')

  useEffect(() => {
    async function loadBalance() {
      if (!isConnected || !address || !publicClient) return

      try {
        // 🪙 Leemos todos los datos del contrato en paralelo
        const [rawBalance, tokenSymbol, decimals] = await Promise.all([
          publicClient.readContract({
            address: NUDOS_CONTRACT.address,
            abi: NUDOS_CONTRACT.abi,
            functionName: 'balanceOf',
            args: [address],
          }),
          publicClient.readContract({
            address: NUDOS_CONTRACT.address,
            abi: NUDOS_CONTRACT.abi,
            functionName: 'symbol',
          }),
          publicClient.readContract({
            address: NUDOS_CONTRACT.address,
            abi: NUDOS_CONTRACT.abi,
            functionName: 'decimals',
          }),
        ])

        setBalance(formatUnits(rawBalance, Number(decimals)))
        setSymbol(tokenSymbol ?? 'NUDOS')
      } catch (err) {
        console.error('Error al cargar balance:', err)
        setBalance(null)
      }
    }

    loadBalance()
  }, [isConnected, address, publicClient])

  if (!isConnected) return <p>Conecta tu wallet para ver tu balance 💫</p>

  return (
    <div className="p-4 text-center">
      {balance ? (
        <p className="text-lg font-semibold">
          Tu balance: {balance} {symbol}
        </p>
      ) : (
        <p>Cargando...</p>
      )}
    </div>
  )
}
