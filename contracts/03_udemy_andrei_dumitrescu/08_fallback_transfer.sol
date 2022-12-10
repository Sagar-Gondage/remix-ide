// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Deposite {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}
    fallback() external payable {}

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // send ether to the contract
    function sendEther() public payable {
        //code
    }

    function transferEther(address payable recipient, uint amount) public returns(bool) {
        require(owner == msg.sender, "Transfer failed,You are not the owner");
        if(amount <= getBalance()) {
            recipient.transfer(amount);
            return true;
        } else {
            return false;
        }
    }
}