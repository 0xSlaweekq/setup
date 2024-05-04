import React, { useEffect, useRef } from 'react';
import { ToastContainer } from 'react-toastify';
import { useAccount, useNetwork } from 'wagmi';

import Claim from '../Dashboard/Claim.tsx';
import { Faq, faqData, Mint, Staking, Stats } from '../Dashboard/index.ts';
import getContracts from '../helpers/getContracts.ts';

function Dashboard() {
  const mountedRef = useRef(true);
  const { isConnected } = useAccount();
  const { chain } = useNetwork();
  const { token, mint, stake } = getContracts();
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    let t = setTimeout(() => {}, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected]);
  return (
    <div className='Dash'>
      <ToastContainer
        position='top-center'
        autoClose={3000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme='dark'
        draggablePercent={60}
      />
      <div className='Dash_cont_right'>
        <Mint token={token} mint={mint} stake={stake} chain={chain} />
        <Claim token={token} mint={mint} stake={stake} chain={chain} />
        <Stats mint={mint} stake={stake} chain={chain} />
      </div>
      <div className='Dash_cont_left'>
        <Staking token={token} mint={mint} stake={stake} chain={chain} />
        <div className='accordion'>
          {faqData.map(({ id, title, content }) => (
            <Faq key={id} title={title} content={content} />
          ))}
        </div>
      </div>
    </div>
  );
}
export default Dashboard;
