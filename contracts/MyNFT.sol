// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    struct NFT {
        uint rarity;
        uint tokenId;
        uint date;
    }

    mapping(address => NFT ) _showMyNft;

    function _baseURI() internal pure override returns (string memory) {
        return "link/";
    }

    //Random pick rarity 1-4 and set amount to raritySet mapping
    function setRarity () internal view returns (uint256 _rarity){

        uint256 randomRarity = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp))) % 10;
        if(randomRarity <= 3){return 1;}
        else if (randomRarity <= 6){return 2;}
        else if (randomRarity <=8){ return 3;}
        else if (randomRarity == 9) { return 4;}
    }

    // Check info about my NFT
    function callStruct (address _owner) public view returns(NFT memory _nft) {
         return _showMyNft[_owner];

    }
    
}