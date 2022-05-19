const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("TokenForPay + Manager" , function () {

let owner;
let acc2 , acc3;
let TokenForPayy;
let Managerr;

 before(async function () {

    [owner , acc2 , acc3] = await ethers.getSigners();
    const TokenForPay = await ethers.getContractFactory("TokenForPay" , owner);
    TokenForPayy = await TokenForPay.deploy();
    await TokenForPayy.deployed();

    const Manager = await ethers.getContractFactory("Manager" , owner);
    Managerr = await Manager.deploy();
    await Managerr.deployed();
    
 });

 
 it("MINT ERC20 TOKENS with price 0.0001 ether" , async function () {

    let tokensMint = await TokenForPayy.connect(acc2).buyToken(acc2.address ,{value : ethers.utils.parseEther("1.0")}) ;
    await tokensMint.wait();
    expect(await TokenForPayy.connect(acc2).balanceOf(acc2.address)).to.eq(10000);
    console.log("Balance of owner after buy tokens :",await TokenForPayy.connect(acc2).balanceOf(acc2.address));
   
   });

 it("Approve 3 tokens to send into Manager" , async function () {

      let approve = await TokenForPayy.connect(acc2).approve(Managerr.address , 3) ;
      await approve.wait();
      expect(await TokenForPayy.connect(acc2).allowance(acc2.address , Managerr.address)).to.eq(3);
      console.log("Allowances :",await TokenForPayy.connect(acc2).allowance(acc2.address , Managerr.address));
      
     
     });

  it("Call Manager function which send tokens and start timer" , async function () {

      let buyNFT = await Managerr.connect(acc2).buyNFT(acc2.address , 3 , TokenForPayy.address);
      await buyNFT.wait();
      expect(await Managerr.connect(acc2).checkMyDeposit(acc2.address)).to.eq(3);
      console.log("My deposit :",await Managerr.connect(acc2).checkMyDeposit(acc2.address));
      
   });

   it("Try to take NFT main function must fail with require" , async function () {

      let takeNFTT = await Managerr.connect(acc2).takeNFTMain();
      await takeNFTT.wait();
      // expect(await Managerr.connect(acc2).checkMyDeposit(acc2.address)).to.eq(3);
      // console.log("My deposit :",await Managerr.connect(acc2).checkMyDeposit(acc2.address));
      
   });

   it("Try to take NFT test function must success" , async function () {

      let takeNFTTEST = await Managerr.connect(acc2).takeNftTest();
      await takeNFTTEST.wait();
      expect(await Managerr.connect(acc2).checkMyDeposit(acc2.address)).to.eq(0);
      console.log("My random NFT :", await Managerr.connect(acc2).balanceOf(acc2.address));
      
   });
   
   it("Check my rarity" , async function () {

      let rarity = await Managerr.connect(acc2).myRarity(await Managerr.connect(acc2).balanceOf(acc2.address));
      console.log("My random rarity :", rarity);
      
   });

   it("Take tokens by owner must fail with require" , async function () {

      let takeTokensMain = await Managerr.connect(owner).takeTokensByOwner(TokenForPayy.address);
      await takeTokensMain.wait();
      
   });

   it("Take tokens by owner must success no require" , async function () {

      let takeTokensTest = await Managerr.connect(owner).takeTokensByOwnerTest(TokenForPayy.address);
      await takeTokensTest.wait();
      console.log("owner balance ERC20 : ",await TokenForPayy.connect(owner).balanceOf(owner.address))
      
   });
   

});   