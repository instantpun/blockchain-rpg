pragma solidity ^0.7.5;
// pragma solidity >=0.7.5 <8.0.0;

contract Character {
    string public characterName;
    uint256 public maxHP;
    uint256 public currentHP;
    uint256 public minHP = 0;

    address owner;

    // constructor functions are called once-and-only-once during the contract deployment
    constructor() {
        owner = msg.sender; // owner address is the address of whoever deploys the smart contract
    }

    function setCharacterName(string memory _characterName) public {
        require(msg.sender == owner, "Cannot modify! You are not the owner!");
        //require(length(_characterName) > 8 && length(_characterName) < 20, "Must be greather than 8 characters or less than 20 characters");
        characterName = _characterName;
        // return characterName;
    }
    
    function setMaxHP(uint256 _maxHP) public {
        require(msg.sender == owner, "Cannot modify! You are not the owner!");
        maxHP = _maxHP;
    }

    function setCurrentHP(uint256 _currentHP) public {
        require(msg.sender == owner, "Cannot modify! You are not the owner!");
        currentHP = _currentHP;
    }

    
    function getCharacterName() public view returns(string memory) {
        return characterName;
    }
    
    function getMaxHP() public view returns(uint256) {
        return maxHP;
    }
    
    function getCurrentHP() public view returns(uint256) {
        return currentHP;
    }
}