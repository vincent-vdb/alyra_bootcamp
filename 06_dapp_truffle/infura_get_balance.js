const Web3 = require('web3')
const rpcURL = "https://ropsten.infura.io/v3/b3cb090961644a1199605888262c83f7" //https://infura.io/dashboard/ethereum/b3cb090961644a1199605888262c83f7/settings
const web3 = new Web3(rpcURL)

web3.eth.getBalance("0xc057A35ff0EB3323CA1398Da1b768A35Fc1f4af0", (err, wei) => { 
   balance = web3.utils.fromWei(wei, 'ether'); // convertir la valeur en ether
   console.log(balance);
});


