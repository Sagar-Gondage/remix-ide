// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Auction {
    // mapping which stores key-value pair of bidderAddress and biddingAmount.
    mapping(address => uint) public bids;

    // function used to make a bid.
    // you have to send some ehters while clicking the function - 
    // otherwise default value is stored.
    function bid() payable public {
        bids[msg.sender] = msg.value;
    }
}