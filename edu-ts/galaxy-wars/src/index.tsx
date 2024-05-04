import './polyfills.ts';

import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';

import App from './App.tsx';
import Provider from './context/Provider.tsx';

require('bootstrap/dist/css/bootstrap.min.css');
require('bootstrap/dist/css/bootstrap.css');
require('./index.css');
require('@rainbow-me/rainbowkit/styles.css');
require('react-toastify/dist/ReactToastify.css');
require('antd/dist/reset.css');

const root = createRoot(document.getElementById('root')!);
root.render(
  <React.StrictMode>
    <BrowserRouter window={window}>
      <Provider>
        <App />
      </Provider>
    </BrowserRouter>
  </React.StrictMode>
);
