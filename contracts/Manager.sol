// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./MyNFT.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Manager is MyNFT {

    uint256 public nftPrice = 3;
    address private owner;
    uint256 endTime;
    uint256 startTime;

    mapping(address => uint256) _balanceOfDeposit;
    mapping(address => uint256) _nftOwner;

    // Set owner of contract
    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner () {
        
        require(owner == msg.sender);
        _;
    }

    // Check Nft token just for tests
    function nftOwner (address _owner) public view returns (uint256) {

        return _nftOwner[_owner];
    }

    // Set time start time
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
    function randomNFT (address _owner) private returns (uint256) {

        uint256 randomTokenId = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp))) % 21;

        // just for test to check random tokenId
         _nftOwner[_owner] += randomTokenId;
        return randomTokenId + 1;
    }

    // This function allow user take NFT after 1 minutes
    function takeNFTMain () public returns (uint256) {

        require(block.timestamp >= endTime , "wait 1 minutes");
        require(_balanceOfDeposit[msg.sender] >= 3);
        address recepient = msg.sender;
        _balanceOfDeposit[recepient] -= 3;
        uint256 randomNft = randomNFT(recepient);
        _safeMint( recepient, randomNft);
        setRarity(randomNft);
        return randomNft;
    }

    // This function just for test ignore timeLocker
    function takeNftTest () public {

        // require(block.timestamp >= endTime , "wait 1 minutes");
        require(_balanceOfDeposit[msg.sender] >= 3);
        address recepient = msg.sender;
        _balanceOfDeposit[msg.sender] -= 3;
        uint256 randomNft = randomNFT(recepient);
        _nftOwner[owner] += randomNft;
        _safeMint( recepient, randomNft);
        setRarity(randomNft);
    }

    // Check my balance into Manager
    function checkMyDeposit (address _owner) public view returns (uint256) {
        return _balanceOfDeposit[_owner];
    }

    // Main function to take deposit tokens after 1 minutes
    function takeTokensByOwner (IERC20 erc20) public onlyOwner {

        require(block.timestamp >= endTime , "wait 1 minutes");
        require(address(erc20) != address(0));
        erc20.approve (owner , erc20.balanceOf(address(this)));
        erc20.transfer(owner , erc20.balanceOf(address(this)));
    }

    // Test function to take deposit ignore timeLocker
    function takeTokensByOwnerTest (IERC20 erc20) public onlyOwner {

        // require(block.timestamp >= endTime , "wait 1 minutes");
        require(address(erc20) != address(0));
        erc20.approve (owner , erc20.balanceOf(address(this)));
        erc20.transfer(owner , erc20.balanceOf(address(this)));
    }
    
}