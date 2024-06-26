const path = require("path");
const fs = require("fs");
const solc = require("solc");

const TokenPath = path.resolve(__dirname, "contract", "GTX.sol");

const source = fs.readFileSync(TokenPath, "utf8");

var input = {
  language: "Solidity",
  sources: {
    "GTX.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};


var output = JSON.parse(solc.compile(JSON.stringify(input)));


var contract = output.contracts['GTX.sol']['GTXToken'];


var dirname = 'bin' ;

const ByteCodePath =  path.join(dirname , 'GTX.bin');

fs.writeFileSync(ByteCodePath , contract.evm.bytecode.object);

const AbiPath = path.join(dirname , 'GTX.abi');

fs.writeFileSync(AbiPath , JSON.stringify(contract.abi));

