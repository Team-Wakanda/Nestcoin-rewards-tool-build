import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import { WakandaTokenAbi, WakandaTokenAddress } from "../utilis/constants";
const { ethereum } = window;


export const TransactionContext = React.createContext();

const createEthereumContract = () =>
{
    const provider = new ethers.providers.Web3Provider( ethereum );
    const signer = provider.getSigner();
    const transactionsContract = new ethers.Contract( WakandaTokenAddress, WakandaTokenAbi, signer );

    return transactionsContract;
};


export const TransactionProvider = ( { children } ) =>
{
    const [ currentAccount, setCurrentAccount ] = useState( "" );

    const checkIfWalletIsConnect = async () =>
    {
        try
        {
            if ( !ethereum ) return alert( "Please install MetaMask." );
            const accounts = await ethereum.request( { method: "eth_accounts" } );
            console.log( accounts );

            if ( accounts.length )
            {
                setCurrentAccount( accounts[ 0 ] );
               
            }
            else
            {
                console.log( "No accounts found" );
            }
        } catch ( error )
        {
            console.log( error );

            throw new Error( "No ethereum object" );
        }

    };

    const connectWallet = async () =>
    {

        try
        {
            if ( !ethereum ) return alert( "Please install MetaMask." );

            const accounts = await ethereum.request( { method: "eth_requestAccounts", } );

            setCurrentAccount( accounts[ 0 ] );
            window.location.reload();
        } catch ( error )
        {
            console.log( error );

            throw new Error( "No ethereum object" );
        }
    };

    const disconnect = async () =>
    {
        try
        {
            if ( !ethereum ) return alert( "Please install MetaMask." );
            setCurrentAccount( " " );
            window.location.reload();
        } catch ( error )
        {
            console.log( error );

            throw new Error( "No ethereum object" );
        }
    }
    useEffect( () =>
    {
        checkIfWalletIsConnect();
        disconnect();
    },);

    return (
        <TransactionContext.Provider value={ {
            connectWallet,
            currentAccount,


        } }>
            { children }
        </TransactionContext.Provider> );
}
