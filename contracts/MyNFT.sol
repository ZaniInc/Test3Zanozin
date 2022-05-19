// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    uint8 [4] rarity;
    mapping(uint256 => uint256)raritySet;

    //Random pick rarity 1-4
    function setRarity (uint256 tokenID) internal {

        uint256 randomRarity;
        randomRarity = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        randomRarity = randomRarity % rarity.length;
        if(randomRarity == 0) {randomRarity + 1; raritySet[tokenID] += randomRarity;}
        else{raritySet[tokenID] += randomRarity;}
        
        
    }

    function myRarity (uint256 tokenID) public view returns (uint256) {

        return raritySet[tokenID];

    }

    
}