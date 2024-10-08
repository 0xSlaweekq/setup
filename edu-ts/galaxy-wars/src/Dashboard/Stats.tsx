import { ethers } from 'ethers';
import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { n5 } from '../helpers/formatters.ts';
// import {initialChain}from '../helpers/utils.ts'

function Stats(props: any) {
  const mountedRef = useRef(true);
  const { mint, stake, chain } = props;
  const { isConnected } = useAccount();
  const [stakeS, setStakeS] = useState(0);
  const [stakeO, setStakeO] = useState(0);
  const [stakeG, setStakeG] = useState(0);
  const [mintS, setMintS] = useState(0);
  const [mintO, setMintO] = useState(0);
  const [mintG, setMintG] = useState(0);
  const [totalFarm, setTotalFarm] = useState(0);
  function getStakeS() {
    if (!mountedRef.current) return null;
    stake.getNumOfStakedSoldiers().then((r: any) => setStakeS(r.toString()));
  }
  function getStakeO() {
    if (!mountedRef.current) return null;
    stake.getNumOfStakedOfficers().then((r: any) => setStakeO(r.toString()));
  }
  function getStakeG() {
    if (!mountedRef.current) return null;
    stake.getNumOfStakedGenerals().then((r: any) => setStakeG(r.toString()));
  }
  function getMintS() {
    if (!mountedRef.current) return null;
    mint.getNumOfMintedSoldiers().then((r: any) => setMintS(r.toString()));
  }
  function getMintO() {
    if (!mountedRef.current) return null;
    mint.getNumOfMintedOfficers().then((r: any) => setMintO(r.toString()));
  }
  function getMintG() {
    if (!mountedRef.current) return null;
    mint.getNumOfMintedGenerals().then((r: any) => setMintG(r.toString()));
  }
  function getTotalFarm() {
    if (!mountedRef.current) return null;
    stake.getTotalFarmed().then((r: any) => setTotalFarm(Number(n5.format(Number(ethers.utils.formatEther(r))))));
  }
  useEffect(() => {
    if (!isConnected) return;
    // if (chain?.id !== initialChain) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      getStakeS();
      getStakeO();
      getStakeG();
      getMintS();
      getMintO();
      getMintG();
      getTotalFarm();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected]);
  return (
    <div className='stat'>
      <div className='Statistic'>
        <p
          style={{
            textAlign: 'center'
          }}
        >
          Stake Statistics
        </p>
        <div
          style={{
            display: 'flex',
            justifyContent: 'space-around'
          }}
        >
          <div>
            <u>In stake</u> <br />
            Trooper: {stakeS}
            <br />
            Jedi/ <br />
            Sith: {stakeO}
            <br />
            Legend: {stakeG}
            <br />
          </div>
          <div>
            <u>Minted</u> <br />
            Trooper: {mintS}
            <br />
            Jedi/ <br />
            Sith: {mintO}
            <br />
            Legend: {mintG}
            <br />
          </div>
        </div>
        <br />
        Total earned: {totalFarm} SETH <br />
      </div>
    </div>
  );
}

export default Stats;
                                                                                                                                                   