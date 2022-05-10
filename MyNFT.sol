// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyToken", "MTK") {}
}