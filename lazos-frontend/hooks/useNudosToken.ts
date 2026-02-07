import { useContract, useSigner } from 'wagmi'
import NudosTokenAbi from '../../out/NudosToken.sol/NudosToken.json'

const CONTRACT_ADDRESS = '0xE15a1c28C4185F9d98C1d2E17c2e8497BfeFa23C'

export const useNudosToken = () => {
  const { data: signer } = useSigner()

  const contract = useContract({
    address: CONTRACT_ADDRESS,
    abi: NudosTokenAbi.abi,
    signerOrProvider: signer,
  })

  return contract
}
