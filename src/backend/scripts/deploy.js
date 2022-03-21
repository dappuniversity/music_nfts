async function main() {
  const toWei = (num) => ethers.utils.parseEther(num.toString())
  let royaltyFee = toWei(0.01);
  let prices = [toWei(1), toWei(2), toWei(3), toWei(4), toWei(5), toWei(6), toWei(7), toWei(8)]
  let deploymentFees = toWei(prices.length * 0.01)
  const [deployer, artist] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  // deploy contracts here:
  const NFTMarketplaceFactory = await ethers.getContractFactory("MusicNFTMarketplace");
  nftMarketplace = await NFTMarketplaceFactory.deploy(
    royaltyFee,
    artist.address,
    prices,
    { value: deploymentFees }
  );

  console.log("Smart contract address:", nftMarketplace.address)

  // For each contract, pass the deployed contract and name to this function to save a copy of the contract ABI and address to the front end.
  saveFrontendFiles(nftMarketplace, "MusicNFTMarketplace");
}

function saveFrontendFiles(contract, name) {
  const fs = require("fs");
  const contractsDir = __dirname + "/../../frontend/contractsData";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + `/${name}-address.json`,
    JSON.stringify({ address: contract.address }, undefined, 2)
  );

  const contractArtifact = artifacts.readArtifactSync(name);

  fs.writeFileSync(
    contractsDir + `/${name}.json`,
    JSON.stringify(contractArtifact, null, 2)
  );
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
