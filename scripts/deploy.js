const hre = require("hardhat");

async function main() {
  const BuyNowNFT = await hre.ethers.getContractFactory("BuyNowNFT");
  const BuyNow = await BuyNowNFT.deploy();

  await BuyNow.deployed();

  console.log("BuyNowNFT deployed to:", BuyNow.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
