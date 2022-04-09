// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

//Contract definition conforming to ERC20 standards, can be burnable and access can also be controlled.
//Permissions on the contract can be granted on-demand
contract WakandaToken is ERC20, ERC20Burnable, AccessControl {
    //Hash input using keccak256 hashing
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    //Define constructor with token name and symbol
    constructor() ERC20("Wakanda Token", "WAT") {
        //Grant admin role to the contract deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        //Grant minter role to the contract deployer
        _grantRole(MINTER_ROLE, msg.sender);

        //Mint initial amount of tokens and assign them to the contract deployer
        _mint(msg.sender, 1000 * 10 * decimals());
    }

    //Define funciton for monting and make funciton only callable from address with MINTER_ROLE
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }
}