var Web3 = require('web3');

web3 = new Web3('https://ropsten.infura.io/v3/b3cb090961644a1199605888262c83f7');

// contract abi
var abi = [ { "inputs": [ { "internalType": "uint256", "name": "x", "type": "uint256" } ], "name": "set", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "get", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function", "constant": true } ];

// Contract address
const addr = "0xCbd43b4CF42101693689a1f9C201471d8f505E8f";

var Contract = new web3.eth.Contract(abi, addr);

// FUNCTION must be the name of the function you want to call. 
//Contract.methods.FUNCTION().call().then(console.log);
Contract.methods.get().call().then(console.log);
