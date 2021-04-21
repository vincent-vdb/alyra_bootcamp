pragma solidity 0.6.11;

contract WhiteList {

    struct Person {
        string name;
        uint age;
    }
    
    Person[] public persons;
    
    function add(string memory _name, uint _age) public {
        Person memory person = Person(_name, _age);
        persons.push(person);
    }
    
    function remove() public {
        persons.pop();
    }
}
