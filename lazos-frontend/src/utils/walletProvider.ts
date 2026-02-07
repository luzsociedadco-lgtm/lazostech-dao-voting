import { ethers } from "ethers";

export const getProvider = () => {
  if (typeof window !== "undefined" && (window as any).ethereum) {
    return new ethers.BrowserProvider((window as any).ethereum);
  }
  throw new Error("Ethereum provider not found");
};

export const getSigner = async () => {
  const provider = getProvider();
  await (window as any).ethereum.request({ method: "eth_requestAccounts" });
  return await provider.getSigner();
};
