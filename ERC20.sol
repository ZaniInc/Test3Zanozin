// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ERC20 {


    mapping(address=>uint) private _balances;
    mapping(address=>mapping(address=>uint)) private _allowances;

    string constant nameERC20 = "TOKENS";
    string constant symbolERC20 = "ERC20";
    uint8 decimals = 8;

    uint256 private _totalSupply;
    uint256 public tokenPrice = 0.0001 ether;

    function balanceOfERC20 (address owner)public view returns(uint256){

        return _balances[owner];
    }

    function totalSupply () public view returns(uint256){

        return _totalSupply;
    }

    function mintToken (address recepient , uint256 amount) public {

        require(recepient != address(0));
        require(amount != 0);
        _mint(recepient , amount);

    }

    function transfer (address recepient , uint256 amount) public {

        require(recepient != address(0));
        require(amount != 0);
        require(_allowances[msg.sender][recepient] == amount);
        _transfer(msg.sender, recepient, amount);

    }

    function transferFrom ( address from ,address recepient , uint256 amount) public {

        require(recepient != address(0) && from != address(0));
        require(amount != 0);
        require(_allowances[msg.sender][recepient] == amount);

        _transfer(from, recepient, amount);

    }

    function approve (address from , address recepient , uint amount) public returns (bool success) {

        _allowances[from][recepient] += amount;
        return true;
    }

    function allowance (address from , address recepient) public view returns (uint256) {

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