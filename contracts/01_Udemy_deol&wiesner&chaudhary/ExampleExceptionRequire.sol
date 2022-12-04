// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleExceptionRequire {
    mapping (address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        // if(_amount <= balanceReceived[msg.sender]) {
        //     balanceReceived[msg.sender] -= _amount;
        //     _to.transfer(_amount);
        // }
        // with above logic user cannot withdraw more money than he received in the contract. 
        // means the withdrawmoney transaction still happens.

        // to avoid this we use require    
        require(_amount <= balanceReceived[msg.sender], "Not enough funds to withdraw, aborting LOL!");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}