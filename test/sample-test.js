const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("TokenForPay" , function () {

let owner;
let acc2 , acc3;
let lottery;

 before(async function () {

    [owner , acc2 , acc3] = await ethers.getSigners();
    const TokenForPay = await ethers.getContractFactory("TokenForPay" , owner);
    TokenForPayy = await TokenForPay.deploy();
    await TokenForPayy.deployed();
    
 });

 
 it("MINT ERC20 TOKENS with price" , async function () {

    let tokensMint = await TokenForPayy.buyToken(owner,) ;
    expect(await erc20.connect(acc2).balanceOfTokens(acc2.address)).to.eq(1);
    await tokensMint.wait();
    
  

   });