//pragma solidity ^0.7.5;
pragma solidity >=0.7.5 <8.0.0;

contract Character {
    string public characterName;
    uint256 public maxHP;
    uint256 public currentHP;
    uint256 public minHP = 0;
    int8 public direction = 0; // +1 = up, -1 = down, 3 = left, 4 = right, 0 = null/break

    address owner;

    // constructor functions are called once-and-only-once during the contract deployment
    constructor() {
        owner = msg.sender; // owner address is the address of whoever deploys the smart contract
        setCharacterPosition(random("my_x",10), random("my_y",10));
        // initialize facing
        if ( randomFromBinarySet([0,1]) == 0 ) {
            rand = randomFromBinarySet([-1,1]);
            face.x = pos.x + rand;
            steal.x = pos.x - rand;
        } else {
            rand = randomFromBinarySet([-1,1]);
            face.y = pos.y + rand;
            steal.y = pos.y - rand;
        }
    }

    function random(string memory extraEntropy, uint8 upperLimit) private view returns (uint8) {
        return uint8(uint256(keccak256(block.timestamp, block.difficulty, bytes(extraEntropy)))%upperLimit);
    }

    function randomFromBinarySet(int8[2] _set) private view returns (int8) {
        // rand evaluates to either 0 or 1
        rand = uint8(uint256(keccak256(_set)%_set.length));
        return _set[rand];
    }

    struct characterPosition {
        uint256 x;
        uint256 y;
        string direction;
    }
    characterPosition pos;

    function setCharacterPosition(uint8 _x, uint8 _y) private view returns (bool) {
        pos.x = _x;
        pox.y = _y;
        return true;
    }

    struct characterFacing {
        uint256 x;
        uint256 y;
    }
    characterFacing face;

    function setCharacterFacing(uint8 _x, uint8 _y) private view returns (bool) {
        face.x = _x;
        face.y = _y;
        return true;
    }

    struct characterSteal {
        uint256 x;
        uint256 y;
    }
    characterSteal steal;

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
    
    function getCharacterPosition() public view returns(uint256,uint256) {
        return (pos.x,pos.y);
    }
    
    function moveCharacter(string memory _direction) public {
        require(msg.sender == owner, "Cannot modify! You are not the owner!");
        
        if( keccak256(bytes(_direction)) == keccak256(bytes("up")) ) {   // if else statement
             pos.y = pos.y + 1;
             face.y = face.y + 1;
          } else if( keccak256(bytes(_direction)) == keccak256(bytes("down")) ){
             pos.y = pos.y - 1;
             face.y = face.y - 1;
          } else if( keccak256(bytes(_direction)) == keccak256(bytes("right")) ){
             pos.x = pos.x + 1;
             face.x = face.x + 1;
          } else if( keccak256(bytes(_direction)) == keccak256(bytes("left")) ){
             pos.x = pos.x - 1;
             face.x = face.x - 1;
          }
    }
}