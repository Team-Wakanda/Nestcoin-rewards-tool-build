import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';

import { TransactionProvider } from './contexts/TransactionContext';
import 
  {
    BrowserRouter,

  } from "react-router-dom";

ReactDOM.render(
  <BrowserRouter> 
    <TransactionProvider>
      <App />
    </TransactionProvider>
  </BrowserRouter>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
