var Web3 = require('web3');

web3 = new Web3('https://ropsten.infura.io/v3/b3cb090961644a1199605888262c83f7');

var ethTx = ('0x8adb9780a89fc1a1a8f8119338b617951cbf84ac63c51df0a84aac34a9f4e66f');

web3.eth.getTransaction(ethTx, function(err, result) { 

if (!err  &&  result  !==  null) {
    console.log(result); // Log all the transaction info
    console.log('From Address: '  +  result.from); // Log the from address
    console.log('To Address: '  +  result.to); // Log the to address
    console.log('Ether Transacted: '  + (web3.utils.fromWei(result.value, 'ether'))); // Get the value, convert from Wei to Ether and log it
}
else {
    console.log('Error!', err); // Dump errors here
}
});
