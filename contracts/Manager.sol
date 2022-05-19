// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./MyNFT.sol";
import "./IERC20.sol";

contract Manager is MyNFT {

    uint256 public nftPrice = 3;
    address private owner;
    uint256 endTime;
    uint256 startTime;
    uint256 [20] tokenId;

    mapping(address => uint256) _balanceOfDeposit;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner () {
        
        require(owner == msg.sender);
        _;
    }

    // Set time when call function buyNFT
    function setStartTime () private {
        startTime = block.timestamp;
    }

    // Set time when user can call takeNFT
    function setEndTime () private {
        setStartTime();
        endTime = startTime + 60 seconds;
    }

    // This function send tokens to deposit where tokens are locked
    function buyNFT (address recepient , uint256 tokenAmount , IERC20 erc20Token) public {

        require(tokenAmount == 3 , "Not enough ERC20");
        erc20Token.transferFrom(recepient , address(this) , tokenAmount);
        setEndTime();
        _balanceOfDeposit[recepient] += 3;

    }

    // GET random TOKEN ID
    function randomNFT () private view returns (uint256) {

        uint256 randomTokenId;
        randomTokenId = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));

        randomTokenId = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        randomTokenId = randomTokenId % tokenId.length;
        if(randomTokenId == 0) {randomTokenId + 1; return randomTokenId;}
        else{return randomTokenId;}
    }

    // This function allow user take NFT after 1 minutes
    function takeNFT () public onlyOwner returns (uint256) {

        require(block.timestamp >= endTime , "wait 1 minutes");
        require(_balanceOfDeposit[msg.sender] >= 3);
        address recepient = msg.sender;

        _safeMint( recepient, randomNFT());
        setRarity(randomNFT());

        return randomNFT();

    }

    function takeTokensByOwner (IERC20 erc20) public onlyOwner {

        require(block.timestamp >= endTime , "wait 1 minutes");
        require(address(erc20) != address(0));

        erc20.approve (owner , erc20.balanceOf(address(this)));
        erc20.transfer(owner , erc20.balanceOf(address(this)));


    }
    
}