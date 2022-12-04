// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleExceptionRequire {
    mapping (address => uint8) public balanceReceived;

    function receiveMoney() public payable {
        // now with assert you cannot send more money than the limit assigned to the value;
        assert(msg.value == uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {   
        require(_amount <= balanceReceived[msg.sender], "Not enough funds to withdraw, aborting LOL!");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}