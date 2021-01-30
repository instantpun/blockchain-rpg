pragma solidity ^0.7.0;

contract SendMoney {
    uint public amountReceived;
    
    function receiveMoney() public payable {
        amountReceived += msg.value; // "msg" is a special object that is generated during a transaction
        // when eth/wei is sent to this contract address, it will increment amountReceived by the value specified in the transaction
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance; // "this" is a built-in variable for the current contract, which is then cast as address variable
    }

    function withdrawMoney() public {
        address payable to = msg.sender; // create an address variable called "to", whose value is the address of the transaction sender; "payable" keyword allows sending of money
        
        to.transfer(this.getBalance()); // .transfer() is a method  associated with the address data type
        
    }
    
    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}

