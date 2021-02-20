//pragma solidity ^0.7.5;
pragma solidity >=0.7.5 <8.0.0;
// import {Memory} from "../unsafe/Memory.sol";

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
        int8[2] memory xy_set;
        xy_set[0]=0;
        xy_set[1]=1;
        int8 eval = randomFromBinarySet(xy_set, "faceplant");
        int8 rand = randomFromBinarySet([-1,1], "faceplant");

        //Issue: rand is being defined twice when you only need it once
        if ( eval == 0 ) {        
            face.x = uint8(int8(pos.x) + rand);
            steal.x = uint8(int8(pos.x) - rand);
        } else {
            face.y = uint8(int8(pos.y) + rand);
            steal.y = uint8(int8(pos.y) - rand);
        }
    }
    
    // function concat(bytes memory self, bytes memory other) internal pure returns (bytes memory) {
    //     bytes memory ret = new bytes(self.length + other.length);
    //     var (src, srcLen) = Memory.fromBytes(self);
    //     var (src2, src2Len) = Memory.fromBytes(other);
    //     var (dest,) = Memory.fromBytes(ret);
    //     var dest2 = dest + srcLen;
    //     Memory.copy(src, dest, srcLen);
    //     Memory.copy(src2, dest2, src2Len);
    //     return ret;
    // }
    
    // function random(string memory extraEntropy, uint8 upperLimit) private view returns (uint8) {
    //     mybytes = concat(bytes(block.timestamp), bytes(block.difficulty));
    //     mybytes2 = concat(mybytes, bytes(extraEntropy));
    //     return uint8(uint256(keccak256(mybytes2) )%upperLimit);
    // }

    function random(string memory extraEntropy, uint8 upperLimit) private view returns (uint8) {
        return uint8(uint256(keccak256(bytes(extraEntropy)) )%upperLimit);
    }
    
    function randomFromBinarySet(int8[2] memory _set, string memory extraEntropy) private view returns (int8) {
        // rand evaluates to either 0 or 1
        uint8 rand = uint8(uint256(keccak256(bytes(extraEntropy)))%_set.length);
        return _set[rand];
    }

    struct characterPosition {
        uint8 x;
        uint8 y;
        string direction;
    }
    characterPosition pos;

    function setCharacterPosition(uint8 _x, uint8 _y) private returns (bool) {
        pos.x = _x;
        pos.y = _y;
        return true;
    }

    struct characterFacing {
        uint256 x;
        uint256 y;
    }
    characterFacing face;

    function setCharacterFacing(uint8 _x, uint8 _y) private returns (bool) {
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
    
    function getCharacterFacing() public view returns(uint256,uint256) {
        return (face.x,face.y);
    }
    
    function getCharacterSteal() public view returns(uint256,uint256) {
        return (steal.x,steal.y);
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