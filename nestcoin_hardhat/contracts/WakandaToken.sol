// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

//Contract definition conforming to ERC20 standards, can be burnable and access can also be controlled.
//Permissions on the contract can be granted on-demand
contract WakandaToken is ERC20, ERC20Burnable, AccessControl {
    //Hash input using keccak256 hashing
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    //Hash input for batch transfer role using keccak256
    bytes32 public constant BATCH_TRANSFER_ROLE = keccak256("BATCH_TRQNFER_ROLE");

    event BatchTransferDelegated (address account);
    //Define constructor with token name and symbol
    constructor() ERC20("Wakanda Token", "WAT") {
        //Grant admin role to the contract deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        //Grant minter role to the contract deployer
        _grantRole(MINTER_ROLE, msg.sender);

        //Grant batch transfer role to contract deployer
        _grantRole(BATCH_TRANSFER_ROLE, msg.sender);

        //Mint initial amount of tokens and assign them to the contract deployer
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    //Define funciton for monting and make funciton only callable from address with MINTER_ROLE
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function batchTransfer(address[] calldata recipients, uint256[] calldata amounts) public onlyRole (BATCH_TRANSFER_ROLE)  returns (bool){
        require(recipients.length == amounts.length, "Number of recipients is not equal to amounts to be transferred");
        require(recipients.length <= 200, "Number of recipients exceeds maximum allowable");
                     
        //Trnasfer tokens to adddresses
        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Cannot transfer to address 0");
            require(balanceOf(address(this))  >= amounts[i], "Balance not enough to continue transfer");
            
            transfer(recipients[i], amounts[i] * 10 ** decimals());
        }
        return true;
    }

    function delegateBatchTransfer (address account) public onlyRole (DEFAULT_ADMIN_ROLE) returns(bool) {
        require(account != address(0), "Cannot delegate to address 0");
        _grantRole(BATCH_TRANSFER_ROLE, account);
        
        emit BatchTransferDelegated(account);
        return true;
    }
}