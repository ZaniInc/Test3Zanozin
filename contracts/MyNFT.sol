// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    mapping(uint256 => uint256)raritySet;

    function _baseURI() internal pure override returns (string memory) {
        return "link/";
    }

    //Random pick rarity 1-4
    function setRarity (uint256 tokenID) internal {

        uint256 randomRarity;
        randomRarity = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp))) % 10;
        if(randomRarity <= 3){raritySet[tokenID] += 1;}
        else if (randomRarity <= 6){raritySet[tokenID] += 2;}
        else if (randomRarity <=8){ raritySet[tokenID] += 3;}
        else if (randomRarity == 9) { raritySet[tokenID] += 4;}
    }

    // Just for test view function
    function myRarity (uint256 tokenID) public view returns (uint256) {

        return raritySet[tokenID];
    }
    
}