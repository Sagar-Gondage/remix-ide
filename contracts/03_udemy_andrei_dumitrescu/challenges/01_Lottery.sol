// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Lottery {
    address payable[] public players;
    address public manager;

    constructor() {
        manager = msg.sender;
    }

    receive() external payable {
        // 0.1 ether = 100000000000000000 wei
        require(msg.value == 0.1 ether, "You can only send 0.1 ether.");
        // as addreeses are payable addrresses so we make sender payable
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint) {
        require(msg.sender == manager, "Only manager can view the balance.");
        return address(this).balance;
    }

    // helper function that returns a big random number
    function random() public view returns(uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        players.length
                    )
                )
            );
    }

    // select the winner
    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick the winner");
        require(
            players.length >= 3,
            "Atleast 3 players should participate in the lottery"
        );

        // computing random index of an array
        uint r = random();
        uint winnerIndex = r % players.length;

        address payable winner; // payable because we want to transfer winning amount as well
        
        winner = players[winnerIndex];
        winner.transfer(getBalance());

        //reset the lottery
        players = new address payable[](0);
    }
}