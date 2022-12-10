// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
manager => person who deployes the contract.
    => pick winner and transfer winning amount to winner and never participate in lottery.
       and reset the lottery so we can start the lottery again.
winning price => balance of the contract.

players => it will be an array.
    => every player has to pay some min amount to enter in the lottery.
       amount paid by new player will keep adding in the contract.
       one player can enter in the lottery once.

How to pick the winner?
     => generate a random number and that will be the winner.
        but we cannot directly use the random number as it could be very large in size,
        so to avoid that will do randomNumber % players.length.
        and this index will be the winner.
*/

contract Lottery {
    address public manager;
    address payable[] public players;

    constructor() {
        manager = msg.sender;
    }

    function alreadyEntered() view private returns(bool) {
        for(uint i = 0; i < players.length; i++) {
            if(msg.sender == players[i]) {
                return true;
            } 
        }
        return false;
    }

    function enter() payable public {
        require(msg.sender != manager, "Manager cannot enter in the lottery");
        require(alreadyEntered() == false, "Player already entered in the lottery");
        require(msg.value >= 1 ether, "Minimum amount must be paid");
        players.push(payable(msg.sender));
    }

    function randomNumber() view private returns(uint) {
        return uint(sha256(abi.encodePacked(block.difficulty, block.number, players)));
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick a winner");
        uint winnerIndex = randomNumber() % players.length;
        address contractAddress = address(this);
        players[winnerIndex].transfer(contractAddress.balance);
        players = new address payable[](0);
    }

    function getPlayers() public view returns(address payable[] memory) {
        return players;
    }
}