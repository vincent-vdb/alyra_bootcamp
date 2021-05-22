var Tx     = require('ethereumjs-tx').Transaction
const Web3 = require('web3')
const web3 = new Web3('https://ropsten.infura.io/v3/b3cb090961644a1199605888262c83f7')
const ABI = [ { "inputs": [ { "internalType": "uint256", "name": "x", "type": "uint256" } ], "name": "set", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "get", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function", "constant": true } ];
const SSaddress = "0xCbd43b4CF42101693689a1f9C201471d8f505E8f";
const account1 = '0xc057A35ff0EB3323CA1398Da1b768A35Fc1f4af0' // Your account address 1
const privateKey1 = Buffer.from('24c0e261d3ed7be843439a8629a39fc7173413832c809cb755003bf1f24ae650', 'hex')

// Deploy the contract
web3.eth.getTransactionCount(account1, (err, txCount) => {
 const simpleStorage = new web3.eth.Contract(ABI, SSaddress);
 const data = simpleStorage.methods.set(245).encodeABI();
  const txObject = {
   nonce:    web3.utils.toHex(txCount),
   gasLimit: web3.utils.toHex(1000000), // Raise the gas limit to a much higher amount
   gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
   to: SSaddress,
   data: data
 }

 var tx = new Tx(txObject, {'chain':'ropsten'});
 tx.sign(privateKey1)

 const serializedTx = tx.serialize()
 const raw = '0x' + serializedTx.toString('hex')

 web3.eth.sendSignedTransaction(raw, (err, txHash) => {
   console.log('err:', err, 'txHash:', txHash)
   // Use this txHash to find the contract on Etherscan!
 })
})
