require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();


const {
  API_URL,
  PRIVATE_KEY_1,
  PRIVATE_KEY_2,
  PRIVATE_KEY_3,
  PRIVATE_KEY_4,
  PRIVATE_KEY_5,
  etherscanApiKey,
} = process.env;

module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "goerli",
  paths: {
    artifacts: "./src/backend/artifacts",
    sources: "./src/backend/contracts",
    cache: "./src/backend/cache",
    tests: "./src/backend/test",
  },
  networks: {
    hardhat: {
      chainId: 1337,
    },
    goerli: {
      url: `${API_URL}`,
      accounts: [
        `${PRIVATE_KEY_1}`,
        `${PRIVATE_KEY_2}`,
        `${PRIVATE_KEY_3}`,
        `${PRIVATE_KEY_4}`,
        `${PRIVATE_KEY_5}`,
      ],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: etherscanApiKey,
  },
};
