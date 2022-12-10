// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract GlobalVariables {
    address public owner;
    uint public sentValue;

    constructor() {
        owner = msg.sender;
    }

    // change the owner
    function changeOwner() public {
        owner = msg.sender;
    }

    // send ether to the smart contract
    function sentEther() public payable {
        sentValue = msg.value;
    }

    // get the balance of current contract.
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // to check how much gas is left after performing certain operation.
    // here if i < 20 => gas left is 7604;
    // if i < 30 => gas left is 11574;
    // if i < 40 => gas left is 15544;
    // if i < 50 => gas left is 19514;
    // if i < 60 => loop fials;
    // so why gas left increases with increase in iteration.
    function howMuchGas() public view returns(uint, uint, uint) {
        uint start = gasleft();
        uint j = 1;
        for(uint i = 1; i < 50; i++) {
            j *= i;
        }
        uint end = gasleft();
        return (start, end, start - end);
    }
}