export const NUDOS = {
  address: '0xE15a1c28C4185F9d98C1d2E17c2e8497BfeFa23C', // contrato en Base Sepolia
  abi: [
    {
      constant: true,
      inputs: [{ name: 'account', type: 'address' }],
      name: 'balanceOf',
      outputs: [{ name: '', type: 'uint256' }],
      type: 'function',
    },
    {
      constant: true,
      inputs: [],
      name: 'decimals',
      outputs: [{ name: '', type: 'uint8' }],
      type: 'function',
    },
    {
      constant: true,
      inputs: [],
      name: 'symbol',
      outputs: [{ name: '', type: 'string' }],
      type: 'function',
    },
    {
      constant: true,
      inputs: [],
      name: 'name',
      outputs: [{ name: '', type: 'string' }],
      type: 'function',
    },
  ],
};
