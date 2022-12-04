// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MappingStructExample {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) deposits;
        uint numWithdrawls;
        mapping(uint => Transaction) withdrawls;
    }

    mapping(address => Balance) public balances;

    function getDepositNum(address _from, uint _numDeposit) public view returns(Transaction memory) {
        return balances[_from].deposits[_numDeposit];
        // _numDeposite means to get specific number of deposite
    }

    function depositeMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits++;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        balances[msg.sender].totalBalance -= _amount;

        Transaction memory withdrawl = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawls[balances[msg.sender].numWithdrawls] = withdrawl;
        balances[msg.sender].numWithdrawls++;

        _to.transfer(_amount);
    }
}