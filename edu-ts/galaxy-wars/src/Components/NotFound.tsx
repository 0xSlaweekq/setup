import * as React from 'react';
import { NavLink } from 'react-router-dom';

function NotFound() {
  return (
    <div className='Home_cont'>
      <div className='notfound'>
        Come back later, this section is temporarily closed. For now, you can go{' '}
        <NavLink className='link' to='/'>
          {' '}
          Home
        </NavLink>{' '}
        and see out our links.
      </div>
    </div>
  );
}
export default NotFound;
