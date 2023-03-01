**Buy Now / Faux Marketplace Sample**

The primary feature of this sample project is that it allows buyers to select the NFT they want to purchase instead of random or unrevealed in a standard mint flow.

No warranty or guarantee of any sort is included with this ***SAMPLE*** software package.

**Getting Started**

Clone the repository

`git clone git@github.com:Crossmint/buy-now-nft.git`

Install the dependencies

`yarn install`


Copy the .env file template

`cp sample.env .env`

Add required environment variables

```env
# goerli testnet
GOERLI_RPC_URL=
ETHERSCAN_KEY=
# mumbai testnet
MUMBAI_RPC_URL=
POLYGONSCAN_KEY=
# deployment wallet
PUBLIC_KEY=
PRIVATE_KEY=
```

1. You can get RPC urls from providers such as https://infura.io/, https://www.alchemy.com/, etc. 

2. Get an Etherscan key (to verify your contract)
https://info.etherscan.com/etherscan-developer-api-key/

3. Save your public key address to the .env file

4. Export private key from metamask or another wallet. You probably should not use the same wallet that you store mainnet assets in. Create a new dev focused metamask account to minimize the risk of storing your private key in plaintext files. 

---

**To deploy the contract to a testnet run the following command:**

`npx hardhat run --network goerli scripts/deploy.js`

Wait about a minute and then verify the Contract. (You'll need an etherscan/polygonscan API key)

`npx hardhat verify --network goerli "0x__CONTRACT_ADDR_FROM_PREVIOUS_STEP__"`

---

Now that you have a real deal contract deployed you're ready to add crossmint support. 
Get started here: https://docs.crossmint.com/docs/payments-introduction