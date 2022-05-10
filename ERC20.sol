// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./IERC20.sol";

contract ERC20 is IERC20 {


    mapping(address=>uint) private _balances;
    mapping(address=>mapping(address=>uint)) private _allowances;

    string private nameERC20;
    string private symbolERC20;
    uint8 decimals = 18;

    uint256 private _totalSupply;

    constructor(string memory name_, string memory symbol_) {
        nameERC20 = name_;
        symbolERC20 = symbol_;
    }

    function balanceOf (address owner)public view override returns(uint256){

        return _balances[owner];
    } 

    function totalSupply () public view override returns(uint256){

        return _totalSupply;
    }

    function mintToken (address recepient , uint256 amount) public {

        require(recepient != address(0));
        require(amount != 0);
        _mint(recepient , amount);

    }

    function transfer (address recepient , uint256 amount) public override returns(bool) {

        require(recepient != address(0));
        require(amount != 0);
        require(_allowances[msg.sender][recepient] == amount);
        _transfer(msg.sender, recepient, amount);

    }

    function transferFrom ( address from ,address recepient , uint256 amount) public override returns(bool) {

        require(recepient != address(0) && from != address(0));
        require(amount != 0);
        require(_allowances[msg.sender][recepient] == amount);

        _transfer(from, recepient, amount);

    }

    function approve (address recepient , uint amount) public override returns (bool success) {

        _allowances[msg.sender][recepient] += amount;
        return true;
    }

    function allowance (address from , address recepient) public view override returns (uint256) {

        return _allowances[from][recepient];
    }

    function _transfer (address from ,address recepient , uint256 amount) private {

        _balances[from] -= amount;
        _balances[recepient] += amount;

    }

    function _mint (address recepient , uint256 amount) private {

         _balances[recepient] += amount;
         _totalSupply += amount;

    }
    
}