import { ethers } from "ethers";
import { NUDOS_CONTRACT } from "./contracts";

export const getProvider = () => {
  if (typeof window === "undefined") {
    throw new Error("window is undefined — el código se está ejecutando en el servidor");
  }

  const provider = new ethers.BrowserProvider(window.ethereum);
  return provider;
};

export const getContract = async () => {
  const provider = getProvider();
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(
    NUDOS_CONTRACT.address,
    NUDOS_CONTRACT.abi,
    signer
  );
  return contract;
};
