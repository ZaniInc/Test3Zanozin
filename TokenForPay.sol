// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./ERC20.sol";

contract TokenForPay is ERC20  { 

    uint256 public tokenPricee = 0.0001 ether;

    constructor() ERC20("TokenForPay", "TFP") {}


}
