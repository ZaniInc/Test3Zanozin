// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// import "./ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenForPay is ERC20  { 

    uint256 public tokenPrice = 0.0001 ether;

    constructor() ERC20("TokenForPay", "TFP") {}

    // Buy tokens by ether
    function buyToken(address recepient)public payable returns(bool) {

        require(recepient != address(0));
        // 0.0001 = 100000000000000 ether
        require(msg.value >= 0.0001 ether);

        uint256 tokenAmount;
        tokenAmount = msg.value / tokenPrice;
        _mint(recepient, tokenAmount);
        return true;

    }


}