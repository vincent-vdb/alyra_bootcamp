pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Admin is Ownable {
    
    mapping(address=>bool) _whiteList;
    mapping(address=>bool) _blackList;
    
    event WhiteListed(address _address);
    event BlackListed(address _address);

    
    function whitelist(address _address) public onlyOwner {
        WhiteListed(_address);
        _whiteList[_address] = true;
    }
    
    function blacklist(address _address) public onlyOwner {
        BlackListed(_address);
        _blackList[_address] = true;
    }


    function isWhitelisted(address _address) public view returns(bool) {
        return _whiteList[_address];
    }

    function isBlacklisted(address _address) public view returns(bool) {
        return _blackList[_address];
    }
    
}
