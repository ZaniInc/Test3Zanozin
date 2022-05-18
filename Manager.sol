// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./MyNFT.sol";
import "./TokenForPay.sol";

contract Manager is MyNFT , TokenForPay {

    function buyNFT (address spender, address _recepient , uint256 _amountTokens , TokenForPay b ) public returns (string memory wait) {

        b.transferFrom(spender ,_recepient, _amountTokens);
        return "wait 60 second";
    } 
    
}