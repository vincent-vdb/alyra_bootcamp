pragma solidity 0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Bank {
    
    using SafeMath for uint;
    
    mapping(address=>uint) _balances;
    
    function deposit(uint _amount) public {
        _balances[msg.sender] = _balances[msg.sender].add(_amount);
    }
    
    function transfer(address _recipient, uint _amount) public {
        require(_amount <= _balances[msg.sender]);
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        
    }
    
    function balanceOf(address _address) public view returns (uint) {
        return _balances[_address];
    }
    
}
