import { useAddRecentTransaction } from '@rainbow-me/rainbowkit';
import React, { useEffect, useRef } from 'react';
import { useAccount } from 'wagmi';

import { n4 } from '../helpers/formatters.ts';
import { errorChain, errorMessage, initialChain, notify, TOKEN_ADDR } from '../helpers/utils.ts';
import { useContracts, useIsPause, useTokenBalance } from '../hooks/index.ts';
import useNFTBalanceStake from '../hooks/useNFTBalanceStake.ts';

function Claim(props: any) {
  const mountedRef = useRef(true);
  const { mint, token, stake, chain } = props;
  const { address, isConnected } = useAccount();
  const { idJediOne } = useNFTBalanceStake(mint, stake, chain);
  const { currentSteelPrice } = useContracts(mint, stake, chain);
  const { balances } = useTokenBalance(token, chain);
  const { isStakePause } = useIsPause(mint, stake, chain);
  const addRecentTransaction = useAddRecentTransaction();
  const buy = `https://pancakeswap.finance/swap?chain=bscTestnet&outputCurrency=${TOKEN_ADDR}`;
  //   const buy = `https://pancakeswap.finance/swap?chain=bsc&outputCurrency=${TOKEN_ADDR}`;
  // Harvest Function
  async function harvestAll() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('harvest');
    if (isStakePause) notify('Contract not started', 'error', 'harvest');
    notify('Claiming', 'loading', 'harvest');
    try {
      const tx = await stake.harvestAll();
      addRecentTransaction({ hash: tx.hash, description: 'Claimed for all' });
      await tx.wait();
      notify('Successfully claimed for all', 'success', 'harvest');
    } catch (e) {
      errorMessage(e, 'harvest');
    }
  }

  async function Hypnosis() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('hypnosis');
    if (isStakePause) notify('Contract not started', 'error', 'hypnosis');
    else notify('Hypnosis Jedi/Sith', 'loading', 'hypnosis');
    try {
      const tx = await stake.stealReward(idJediOne, {
        from: address,
        value: currentSteelPrice
      });
      addRecentTransaction({ hash: tx.hash, description: 'Hypnosis' });
      await tx.wait();
      notify('Successfully hypnosis', 'success', 'hypnosis');
    } catch (e) {
      errorMessage(e, 'hypnosis');
    }
  }

  useEffect(() => {
    if (!isConnected) return;
    // if (chain?.id !== initialChain) return;
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
    };
  }, [address, isConnected]);
  return (
    <div className='claim'>
      <div className='claim_in'>
        <span className='balance'>Your balance: {n4.format(balances)} SETH</span>
        <br />
        <br />
        Click Claim all for harvest your all SETH <br /> <br />
        Click Hypnosis for steal earned SETH another user <br /> <br />
        (only if you have 1 or more Jedi or Sith in stake)
      </div>
      <div className='claim_btn'>
        <button className='connect' onClick={harvestAll}>
          Claim all
        </button>
        <button className='connect' onClick={Hypnosis}>
          Hypnosis
        </button>
      </div>
      <br />
      <div className='claim_btn'>
        <a className='connect' target='_blank' rel='noopener noreferrer' href={buy}>
          BUY SETH
        </a>
      </div>
    </div>
  );
}

export default Claim;
