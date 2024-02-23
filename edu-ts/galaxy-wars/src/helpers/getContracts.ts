import { ethers } from 'ethers';
import { useEffect, useRef } from 'react';
import { useAccount, useContract, useNetwork, useProvider, useSigner } from 'wagmi';

import { initialChain, MINT_ABI, MINT_ADDR, sleep, STAKE_ABI, STAKE_ADDR, TOKEN_ABI, TOKEN_ADDR } from './utils.ts';

function getContracts() {
  const mountedRef = useRef(true);
  const provider = useProvider();
  const { address, isConnected, status } = useAccount();
  const { chain } = useNetwork();
  const { data: signer }: any = useSigner({
    onError(e) {
      console.error('Error: ', e);
    },
    onSuccess(data) {
      console.log('Success getting Signer');
    }
  });
  const ankrId = process.env.REACT_APP_ANKR_ID;
  const RPC = `https://rpc.ankr.com/bsc_testnet_chapel/${ankrId}`;
  const w3 = new ethers.providers.JsonRpcProvider(RPC);
  let token;
  let mint;
  let stake;

  if (chain?.id !== initialChain) {
    token = useContract({ address: TOKEN_ADDR, abi: TOKEN_ABI, signerOrProvider: w3 });
    mint = useContract({ address: MINT_ADDR, abi: MINT_ABI, signerOrProvider: w3 });
    stake = useContract({ address: STAKE_ADDR, abi: STAKE_ABI, signerOrProvider: w3 });
  } else {
    token = useContract({ address: TOKEN_ADDR, abi: TOKEN_ABI, signerOrProvider: signer || provider });
    mint = useContract({ address: MINT_ADDR, abi: MINT_ABI, signerOrProvider: signer || provider });
    stake = useContract({ address: STAKE_ADDR, abi: STAKE_ABI, signerOrProvider: signer || provider });
  }
  //   window.useContracts = { token, mint, stake };
  useEffect(() => {
    mountedRef.current = true;
    const t = setTimeout(async () => {
      if (status === 'connecting') console.log('Provider status: ', status);
      if (status === 'disconnected') console.log('Provider status: ', status);
      if (isConnected && status === 'connected' && signer) {
        await (async () => {
          while (signer?._address !== address) {
            await sleep(100);
          }
        })();
        if (status === 'connected') console.log('Provider status: ', status);
        if (signer?.provider?.provider?.on)
          signer.provider.provider
            .on('accountsChanged', (accounts: any) => console.log(accounts))
            .on('chainChanged', (chainId: any) => console.log(chainId))
            .on('network', (newNetwork: any, oldNetwork: any) => console.log(newNetwork, oldNetwork))
            .on('disconnect', (disconnect: any) => console.log(disconnect));
      }
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
      if (signer?.provider?.provider?.removeListener)
        signer.provider.provider
          .removeListener('accountsChanged', (accounts: any) => console.log(accounts))
          .removeListener('chainChanged', (chainId: any) => console.log(chainId))
          .removeListener('network', (newNetwork: any, oldNetwork: any) => console.log(newNetwork, oldNetwork))
          .removeListener('disconnect', (disconnect: any) => console.log(disconnect));
    };
  }, [signer, isConnected, status, address]);
  return { token, mint, stake, signer, provider };
}
export default getContracts;
