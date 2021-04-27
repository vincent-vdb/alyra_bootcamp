pragma solidity 0.6.3;


// Taken from https://fravoll.github.io/solidity-patterns/pull_over_push.html
contract PullOverPush {

    // Public, so that anyone can check if they have anything to withdraw
    mapping(address => uint) public credits;
    
    // To be called anywhere from within the smart contract
    function allowForPull(address receiver, uint amount) private {
        credits[receiver] += amount;
    }

    function withdrawCredits() public {
        uint amount = credits[msg.sender];

        require(amount != 0);
        require(address(this).balance >= amount);

        credits[msg.sender] = 0;

        msg.sender.transfer(amount);
    }
}
