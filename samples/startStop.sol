pragma solidity ^0.7.5;

contract StartStopUpdateExample {
    address owner;
    
    bool paused;
    
    // constructor functions are called once-and-only-once during the contract deployment
    constructor() public {
        owner = msg.sender; // owner address is the address of whoever deploys the smart contract
        
    }
    
    function sendMoney() public payable {
        
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "Cannot pause contract! You are not the owner!"); 
        require(!paused, "Contract is already paused. Cannot pause contract!");
        paused = _paused;
    }
    
    function withdrawMoney(address payable _to) public {
        // instead of if/else logic, solidity has require statements to check state, similar to assert in python
        require(msg.sender == owner, "Cannot withdraw! You are not the owner!"); // if boolean expression evaluates false the transaction is rolled back, and will NOT be reflected in the block chain
        require(paused == false, "Contract is paused. Unable to complete transaction");
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner);
        // to destroy a smart contract you would call a Solidity-specific internal function called 
        selfdestruct(_to);
    }
}