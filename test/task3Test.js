const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("TokenForPay + Manager" , function () {

let owner;
let acc2 , acc3;
let lottery;

 before(async function () {

    [owner , acc2 , acc3] = await ethers.getSigners();
    const TokenForPay = await ethers.getContractFactory("TokenForPay" , owner);
    TokenForPayy = await TokenForPay.deploy();
    await TokenForPayy.deployed();

    const Manager = await ethers.getContractFactory("Manager" , owner);
    Managerr = await Manager.deploy();
    await Managerr.deployed();
    
 });

 
 it("MINT ERC20 TOKENS with price" , async function () {

    let tokensMint = await TokenForPayy.buyToken(acc2 ,{value : ethers.utils.parseEther("1.0")}) ;
    expect(await erc20.connect(acc2).balanceOfTokens(acc2.address)).to.eq(10000);
    await tokensMint.wait();
    
  

   });
});   