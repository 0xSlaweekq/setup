import { useAddRecentTransaction } from '@rainbow-me/rainbowkit';
import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { errorChain, errorMessage, initialChain, notify, STAKE_ADDR } from '../../helpers/utils.ts';
import { useIsApprove, useIsPause, useNFTBalance } from '../../hooks/index.ts';
import JediUnstake from './JediUnstake.tsx';
import LegendUnstake from './LegendUnstake.tsx';
import TrooperUnstake from './TrooperUnstake.tsx';

function Unstaked(props: any) {
  const mountedRef = useRef(true);
  const { token, mint, stake, chain } = props;
  const addRecentTransaction = useAddRecentTransaction();
  const { Trooper, Jedi, Legend } = useNFTBalance(mint);
  const { address, isConnected } = useAccount();
  const { isApprovedNFT } = useIsApprove(token, mint, chain);
  const { isStakePause } = useIsPause(mint, stake, chain);
  // remove dublicates func
  function remover(arr: any) {
    return arr.reduce((a: any, b: any) => {
      if (a.indexOf(b) < 0) a.push(b);
      return a;
    }, []);
  }
  // remove Arr from slected Items
  function fromArrRemover(mainArr: any, toRemove: any) {
    return mainArr.filter((el: any) => !toRemove.includes(el));
  }
  //   get clicked id type
  function getClickedType(id: string | number) {
    return Jedi.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'jedi'
      : Trooper.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'Trooper'
      : Legend.map((x: any) => x.edition).indexOf(id) !== -1
      ? 'Legend'
      : null;
  }
  // Main Function
  async function approve() {
    if (!mountedRef.current) return null;
    notify('Approve NFT for staking', 'loading', 'approveNFT');
    try {
      const tx = await mint.setApprovalForAll(STAKE_ADDR, 'true');
      addRecentTransaction({
        hash: tx.hash,
        description: 'Approve nft for staking'
      });
      await tx.wait();
      notify('Successfully approved nft for staking', 'success', 'approveNFT');
    } catch (e) {
      errorMessage(e, 'approveNFT');
    }
  }
  async function stakeMultiple(i: Array<string | number>) {
    if (!mountedRef.current) return null;
    notify('Staking NFT', 'loading', 'stake');
    try {
      const tx = await stake.stakeMultiple(i);
      addRecentTransaction({ hash: tx.hash, description: 'Staking nft' });
      await tx.wait();
      notify('Successfully staked nft', 'success', 'stake');
    } catch (e) {
      errorMessage(e, 'stake');
    }
  }
  async function staking(z: any) {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('stake');
    if (isStakePause) notify('Contract not started', 'error', 'stake');
    else notify('Staking NFT', 'loading', 'stake');
    if (!isApprovedNFT) await approve();
    else await stakeMultiple(z);
  }
  // Selected
  const [selected, setSelected]: any = useState([]);
  const [selection, setSelection] = useState(false);
  const [selectionT, setSelectionT] = useState(false);
  const [selectionJ, setSelectionJ] = useState(false);
  const [selectionH, setSelectionH] = useState(false);
  function selectAllTrooper() {
    if (!mountedRef.current) return null;
    const allTrooper = Trooper.map((x: any) => x.edition);
    if (selectionT) {
      let selectedArr = [...selected];
      selectedArr = fromArrRemover(selectedArr, allTrooper);
      setSelected(selectedArr);
      setSelectionT(false);
    } else if (!selectionT) {
      const selectedArr = remover([...selected, ...allTrooper]);
      setSelectionT(true);
      setSelected(selectedArr);
    }
  }
  function selectAllJedi() {
    if (!mountedRef.current) return null;
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
    if (!mountedRef.current) return null;
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
  function handleNFTBlockClick(id: number | string) {
    if (!mountedRef.current) return null;
    // Checking for AllSelections if selected, turning off and adding one element
    const clickedType = getClickedType(id);
    if (clickedType === 'Trooper' && selectionT) {
      const allTrooper = Trooper.map((x: any) => x.edition);
      const selectedArr: any = fromArrRemover(selected, allTrooper);
      setSelected([...selectedArr, id]);
      setSelectionT(false);
    }
    if (clickedType === 'Legend' && selectionH) {
      const allLegend = Legend.map((x: any) => x.edition);
      const selectedArr = fromArrRemover(selected, allLegend);
      setSelected([...selectedArr, id]);
      setSelectionH(false);
    }
    if (clickedType === 'jedi' && selectionJ) {
      const allJedi = Jedi.map((x: any) => x.edition);
      const selectedArr = fromArrRemover(selected, allJedi);
      setSelected([...selectedArr, id]);
      setSelectionJ(false);
    }
    if (selected.indexOf(id) === -1) {
      const arr = selected;
      if (!mountedRef.current) return null;
      arr.push(id);
      setSelected(arr);
    } else {
      const arr = selected.filter((i: any) => i !== id);
      if (!mountedRef.current) return null;
      setSelected(arr);
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
    <div className='Unstake'>
      <div className='Stake_nft'>
        <button className='connect' onClick={() => staking(selected)}>
          Stake
        </button>
      </div>
      {Trooper.length !== 0 ? (
        <>
          <br />
          <span>Trooper: {Trooper.length} </span>
          <button className='connect' onClick={selectAllTrooper}>
            {selectionT ? 'Selected' : 'Select all'}
          </button>
          <br />
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Trooper.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <TrooperUnstake
              key={nft.edition}
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
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Jedi.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <JediUnstake
              key={nft.edition}
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
          <br />
        </>
      ) : (
        ''
      )}
      <div className='NFTs'>
        {Legend.map((nft: any) => {
          if (!mountedRef.current) return null;
          return (
            <LegendUnstake
              key={nft.edition}
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
export default Unstaked;
                                             