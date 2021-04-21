pragma solidity 0.6.11;

contract WhiteList {

    mapping (address=>bool) myWhiteList;

    event Authorized(address _address);

    function authorize(address _address) public {
        myWhiteList[_address] = true;
        emit Authorized(_address);
    }

}
