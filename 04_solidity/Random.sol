pragma solidity >=0.6.11;

contract Random {
    uint public nonce = 0;

    function random() public returns (uint) {
        nonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 100;
    }
}

