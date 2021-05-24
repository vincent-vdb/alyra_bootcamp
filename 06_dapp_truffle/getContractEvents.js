var  Web3  =  require('web3');
web3  =  new  Web3('https://ropsten.infura.io/v3/b3cb090961644a1199605888262c83f7');

var  addr  =  "0xF3b1c7cA8fC7427D57328664902d4BD257B2EB0F";

console.log('Events by Address: '  +  addr);

var  abi  = [{"constant":true,"inputs":[],"name":"getEbola","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getInfo","outputs":[{"name":"","type":"string"},{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"tipCreator","outputs":[{"name":"","type":"string"},{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"}]
var  contract  =  new  web3.eth.Contract(abi, '0xe16f391e860420e65c659111c9e1601c0f8e2818');

console.log('-----------------------------------');
console.log('Matching Smart Contract Events');
console.log('-----------------------------------');

contract.getPastEvents('Event1', {
        filter: {_from: addr},
        fromBlock: 0,
        toBlock: 'latest'
}, function(error, events){
        //console.log(events);
    for (i=0; i<events.length; i++) {
        var  eventObj  =  events[i];
        console.log('Address: '  +  eventObj.returnValues._from);
        //console.log('Greeting: ' + web3.utils.hexToAscii(eventObj.returnValues._greeting));
    }
});
