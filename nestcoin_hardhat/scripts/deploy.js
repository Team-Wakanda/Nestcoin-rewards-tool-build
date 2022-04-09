// I deployed Token Contract First 

const hre = require( "hardhat" );

const main = async () =>
{

  const [ deployer ] = await hre.ethers.getSigners();

  console.log( "Deploying contracts with the account:", deployer.address );

  const weiAmount = ( await deployer.getBalance() ).toString();

  console.log( "Account balance:", ( await ethers.utils.formatEther( weiAmount ) ) );


  const WakandaToken = await hre.ethers.getContractFactory( "WakandaToken" );
  




  const WakandaToken_Contract = await WakandaToken.deploy();


  await WakandaToken_Contract.deployed();


  console.log( "WakandaToken_Contract deployed to:", WakandaToken_Contract.address ); //  0x166Fa05046d3ab00da017449AcCE38D99b8A4072
}


const runMain = async () =>
{
  try
  {
    await main();
    process.exit( 0 );
  } catch ( error )
  {
    console.error( error );
    process.exit( 1 );
  }
}
runMain();