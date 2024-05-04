import { useAddRecentTransaction } from '@rainbow-me/rainbowkit';
import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { errorChain, errorMessage, initialChain, notify } from '../../helpers/utils.ts';
import { useIsPause, useTokenBalance } from '../../hooks/index.ts';
import useNFTBalanceStake from '../../hooks/useNFTBalanceStake.ts';
import JediStake from './JediStake.tsx';
import LegendStake from './LegendStake.tsx';
import TrooperStake from './TrooperStake.tsx';

function Staked(props: any) {
  const mountedRef = useRef(true);
  const { token, mint, stake, chain } = props;
  const { Trooper, Jedi, Legend } = useNFTBalanceStake(mint, stake, chain);
  const { address, isConnected } = useAccount();
  const { balances } = useTokenBalance(token, chain);
  const { isStakePause } = useIsPause(mint, stake, chain);
  const addRecentTransaction = useAddRecentTransaction();
  // remove dublicates func
  function remover(arr: Array<number>) {
    return arr.reduce((a: Array<number>, b: number) => {
      if (a.indexOf(b) < 0) a.push(b);
      return a;
    }, []);
  }
  // remove Arr from slected Items
  function fromArrRemover(mainArr: Array<number>, toRemove: Array<number>) {
    return mainArr.filter((el: number) => !toRemove.includes(el));
  }
  // get clicked id type
  function getClickedType(id: number | string) {
    return Jedi.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'Jedi'
      : Trooper.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'Trooper'
      : Legend.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'Legend'
      : null;
  }
  // Select
  const [selected, setSelected]: any[] = useState([]);
  const [selection, setSelection] = useState(false);
  const [selectionT, setSelectionT] = useState(false);
  const [selectionJ, setSelectionJ] = useState(false);
  const [selectionH, setSelectionH] = useState(false);
  function selectAllJedi() {
    const allJedi = Jedi.map((x: any) => x.edition);
    if (selectionJ) {
      let selectedArr = [...selected];
      selectedArr = fromArrRemover(selectedArr, allJedi);
      setSelected(selectedArr);
      setSelectionJ(false);
    } else if (!selectionJ) {
      const selectedArr = remover([...selected, ...allJedi]);
      setSelectionJ(true);
      setSelected(selectedArr);
    }
  }
  function selectAllLegend() {
    const allLegend = Legend.map((x: any) => x.edition);
    if (selectionH) {
      let selectedArr = [...selected];
      selectedArr = fromArrRemover(selectedArr, allLegend);
      setSelected(selectedArr);
      setSelectionH(false);
    } else if (!selectionH) {
      const selectedArr = remover([...selected, ...allLegend]);
      setSelectionH(true);
      setSelected(selectedArr);
    }
  }
  function handleNFTBlockClick(id: string | number) {
    // Checking for AllSelections if selected, turning off and adding one element
    const clickedType = getClickedType(id);
    if (clickedType === 'Trooper' && selectionT) {
      const allTrooper = Trooper.map((x: any) => x.edition);
      const selectedArr = fromArrRemover(selected, allTrooper);
      setSelected([...selectedArr, id]);
      setSelectionT(false);
      return;
    }
    if (clickedType === 'Legend' && selectionH) {
      const allLegend = Legend.map((x: any) => x.edition);
      const selectedArr = fromArrRemover(selected, allLegend);
      setSelected([...selectedArr, id]);
      setSelectionH(false);
      return;
    }
    if (clickedType === 'Jedi' && selectionJ) {
      const allJedi = Jedi.map((x: any) => x.edition);
      const selectedArr = fromArrRemover(selected, allJedi);
      setSelected([...selectedArr, id]);
      setSelectionJ(false);
      return;
    }
    if (selected.indexOf(id) === -1) {
      const arr = selected;
      arr.push(id);
      setSelected(arr);
    } else {
      const arr = selected.filter((i: any) => i !== id);
      setSelected(arr);
    }
  }
  async function harvestSoldiers() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('harvest');
    if (isStakePause) notify('Contract not started', 'error', 'harvest');
    else notify('Claim all Trooper', 'loading', 'harvest');
    try {
      const tx = await stake.harvestSoldiers();
      addRecentTransaction({ hash: tx.hash, description: 'Claim Trooper' });
      await tx.wait();
      notify('Successfully claim Trooper', 'success', 'harvest');
    } catch (e) {
      errorMessage(e, 'harvest');
    }
  }
  async function harvestOfficiers() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('harvest');
    if (isStakePause) notify('Contract not started', 'error', 'harvest');
    else notify('Claim all Jedi/Sith', 'loading', 'harvest');
    try {
      const tx = await stake.harvestOfficers();
      addRecentTransaction({ hash: tx.hash, description: 'Claim Jedi/Sith' });
      await tx.wait();
      notify('Successfully claim Jedi/Sith', 'success', 'harvest');
    } catch (e) {
      errorMessage(e, 'harvest');
    }
  }
  async function harvestGenerals() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('harvest');
    if (isStakePause) notify('Contract not started', 'error', 'harvest');
    else notify('Claim all Legends', 'loading', 'harvest');
    try {
      const tx = await stake.harvestGenerals();
      addRecentTransaction({ hash: tx.hash, description: 'Claim Legends' });
      await tx.wait();
      notify('Successfully claim Legends', 'success', 'harvest');
    } catch (e) {
      errorMessage(e, 'harvest');
    }
  }
  async function unstakeMultipl(i: Array<string | number>) {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('unstake');
    if (isStakePause) notify('Contract not started', 'error', 'unstake');
    else notify('Unstaking Multiple NFT', 'loading', 'unstake');
    try {
      const tx = await stake.unstakeMultiple(i);
      addRecentTransaction({
        hash: tx.hash,
        description: 'Unstake multiple NFT'
      });
      await tx.wait();
      notify('Successfully unstaked', 'success', 'unstake');
    } catch (e) {
      if (balances < 100) notify('You must have 100 SETH on your balance trooper', 'error', 'unstake');
      else errorMessage(e, 'unstake');
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
    <div className='Stake'>
      <div className='Stake_nft'>
        <button className='connect' onClick={() => unstakeMultipl(selected)}>
          Unstake+claim
        </button>
      </div>
      {Trooper.length !== 0 ? (
        <>
          <br />
          <span>Trooper: {Trooper.length} </span>
          <button className='connect' onClick={harvestSoldiers}>
            Claim
          </button>
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Trooper.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <TrooperStake
              key={nft.edition}
              stake={stake}
              nft={nft}
              selection={selection}
              selectionT={selectionT}
              setSelection={setSelection}
              handleNFTBlockClick={handleNFTBlockClick}
            />
          );
        })}
      </div>
      {Jedi.length !== 0 ? (
        <>
          <br />
          <span>Jedi/Sith: {Jedi.length} </span>
          <button className='connect' onClick={selectAllJedi}>
            {selectionJ ? 'Selected' : 'Select all'}
          </button>
          <button className='connect' onClick={harvestOfficiers}>
            Claim
          </button>
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Jedi.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <JediStake
              key={nft.edition}
              stake={stake}
              nft={nft}
              selection={selection}
              selectionJ={selectionJ}
              setSelection={setSelection}
              handleNFTBlockClick={handleNFTBlockClick}
            />
          );
        })}
      </div>
      {Legend.length !== 0 ? (
        <>
          <br />
          <span>Legend: {Legend.length} </span>
          <button className='connect' onClick={selectAllLegend}>
            {selectionH ? 'Selected' : 'Select all'}
          </button>
          <button className='connect' onClick={harvestGenerals}>
            Claim
          </button>
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Legend.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <LegendStake
              key={nft.edition}
              stake={stake}
              nft={nft}
              selection={selection}
              selectionH={selectionH}
              setSelection={setSelection}
              handleNFTBlockClick={handleNFTBlockClick}
            />
          );
        })}
      </div>
    </div>
  );
}
export default Staked;
