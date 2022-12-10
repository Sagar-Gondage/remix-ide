// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AuctionCreator {
    Auction[] public auctions;

    function createAuction() public {
        Auction newAuction = new Auction(msg.sender);
        auctions.push(newAuction);
    }
}

contract Auction {
    address payable public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;
    enum State {
        Started,
        Running,
        Ended,
        Cancelled
    }
    State public auctionState;

    uint public highestBindingBid;
    address payable public highestBidder;

    mapping(address => uint) public bids;

    uint bidIncrement;

    constructor(address eoa) { // eoa => externally owned account.
        owner = payable(eoa);
        auctionState = State.Running;
        startBlock = block.number;
        // endBlock = startBlock + 40320; // one block is generated at every 15 sec in a week 40320 blocks will be generated.
        endBlock = startBlock + 4;
        ipfsHash = "";
        // bidIncrement = 100; // default unit is wei
        bidIncrement = 1000000000000000000;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are the owner. you cannot perform this actions.");
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot place the bid");
        _;
    }

    modifier afterStart() {
        require(block.number >= startBlock, "Its started after start");
        _;
    }

    modifier beforeEnd() {
        require(block.number <= endBlock);
        _;
    }

    function cancelAuction() public onlyOwner {
        auctionState = State.Cancelled;
    }

    function findMin(uint a, uint b) internal pure returns(uint) {
        if(a <=b ) {
            return a;
        } else {
            return b;
        }
    }

    function placeBid() public payable notOwner afterStart beforeEnd {
        require(auctionState == State.Running, "Auction is not in runnig state");
        require(msg.value >= 100, "minimum amount should be 100 wei");

        uint currentBid = bids[msg.sender] + msg.value;
        require(
            currentBid > highestBindingBid,
            "Bid amount should be greater than highestBindingBid"
        );

        bids[msg.sender] = currentBid;

        if(currentBid <= bids[highestBidder]) {
            highestBindingBid = findMin(currentBid + bidIncrement, bids[highestBidder]);
        } else {
            highestBindingBid = findMin(currentBid, bids[highestBidder] + bidIncrement);
            highestBidder = payable(msg.sender);
        }
    }

    function finalizeAuction() public {
        require(auctionState == State.Cancelled || block.number > endBlock);
        require(
            msg.sender == owner || bids[msg.sender] > 0,
            "You are not the owner or your bid amount is 0"
        );

        address payable recipient;
        uint value;

        // if auction is cancelled.
        if(auctionState == State.Cancelled) {
            recipient = payable(msg.sender);
            value = bids[msg.sender];
        } else { // auction ended (not cancelled).
            if(msg.sender == owner) { // this is the owner.
                recipient = owner;
                value = highestBindingBid;
            } else {
                // this is the bidder;
                if(msg.sender == highestBidder) {
                    recipient = highestBidder;
                    value = bids[highestBidder] - highestBindingBid;
                } else {
                    // this is neither the owner nor the highestBidder;
                    recipient = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }
        /*
        resetting the bids of the reciepient to zero so if he
        requiests his funds back again his - funds would become 0.
        */
        bids[recipient] = 0;

        // send value to the reciepient.
        recipient.transfer(value);
    }
}

