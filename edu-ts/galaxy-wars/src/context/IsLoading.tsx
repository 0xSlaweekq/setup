import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

function Load() {
  return (
    <svg
      className='_1luule42'
      fill='none'
      color='inherit'
      height='35px'
      viewBox='0 0 21 21'
      width='35px'
      xmlns='http://www.w3.org/2000/svg'
    >
      <clipPath id='spinner_602637897'>
        <path d='M10.5 3C6.35786 3 3 6.35786 3 10.5C3 14.6421 6.35786 18 10.5 18C11.3284 18 12 18.6716 12 19.5C12 20.3284 11.3284 21 10.5 21C4.70101 21 0 16.299 0 10.5C0 4.70101 4.70101 0 10.5 0C16.299 0 21 4.70101 21 10.5C21 11.3284 20.3284 12 19.5 12C18.6716 12 18 11.3284 18 10.5C18 6.35786 14.6421 3 10.5 3Z'></path>
      </clipPath>
      <foreignObject clipPath='url(#spinner_602637897)' height='21' width='21' x='0' y='0'>
        <div className='_1luule43'></div>
      </foreignObject>
    </svg>
  );
}
function IsLoading(props: any) {
  const { children } = props;
  const [loading, setLoading] = useState(true);
  const mountedRef = useRef(true);
  const { status, isConnected } = useAccount();
  useEffect(() => {
    mountedRef.current = true;
    let t: any;
    if (isConnected && status === 'connected') {
      t = setTimeout(() => {
        setLoading(false);
      }, 300);
    }
    if (!isConnected && status === 'disconnected') {
      t = setTimeout(() => {
        setLoading(false);
      }, 1000);
    }
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected, status]);
  return loading ? (
    <div className='Home_cont'>
      <h1>
        Loading <Load />
      </h1>
    </div>
  ) : (
    children
  );
}
export default IsLoading;
                                                                                                                       