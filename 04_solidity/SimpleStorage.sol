pragma solidity >=0.5.0 <0.7.0;

contract SimpleStorage {
    uint value;
    
    function set(uint x) public {
        value = x;
    }
    
    function get() public view returns (uint) {
        return value;
    }
}
