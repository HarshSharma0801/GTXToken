const HDWalletProvider = require("@truffle/hdwallet-provider");
const  Web3 = require("web3");
const path = require("path");
const fs = require("fs");

const METAMASK_KEY = process.env.METAMASK;
const API_KEY = process.env.API_KEY_SEPOLIA;
const provider = new HDWalletProvider(METAMASK_KEY, API_KEY);

const abiPath = path.resolve(__dirname, "bin", "GTX.abi");
const abi = fs.readFileSync(abiPath, "utf8");

const byteCodePath = path.resolve(__dirname, "bin", "GTX.bin");
const bytecode = fs.readFileSync(byteCodePath, "utf8");

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attempting to deploy from account", accounts[0]);

  const result = await new web3.eth.Contract(JSON.parse(abi))
    .deploy({ data: bytecode })
    .send({ gas: "1000000", from: accounts[0] });

  console.log("Contract deployed to", result.options.address);
  provider.engine.stop();
};
deploy();
