// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    mapping(uint256 => uint256)raritySet;

    //Random pick rarity 1-4
    function setRarity (uint256 tokenID) internal {

        uint256 randomRarity;
        randomRarity = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        randomRarity = randomRarity % 5;
        if(randomRarity == 0) {raritySet[tokenID] = 1;}
        else{raritySet[tokenID] += randomRarity;}
        
        
    }

    function myRarity (uint256 tokenID) public view returns (uint256) {

        return raritySet[tokenID];

    }

    
}