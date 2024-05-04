import { utils } from 'ethers';
import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

function useTokenBalance(token: any, chain: any) {
  const mountedRef = useRef(true);
  const { address, isConnected } = useAccount();
  const [balances, setBalance] = useState(0);
  function getBalanceToken() {
    if (!mountedRef.current) return null;
    token.balanceOf(address).then((r: any) => setBalance(Number(utils.formatEther(r))));
  }
  useEffect(() => {
    if (!isConnected) return;
    // if (chain?.id !== initialChain) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      getBalanceToken();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [address, isConnected]);
  return { balances };
}
export default useTokenBalance;
