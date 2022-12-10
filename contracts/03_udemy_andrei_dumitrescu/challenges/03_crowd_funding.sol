// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {
    mapping(address => uint) public contributors;
    address public admin;
    uint public noOfContributors;
    uint public minimumContribution;
    uint public deadline; // timestamp.
    uint public goal;
    uint public raisedAmount;
    struct Request {
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address => bool) voters;
    }

    mapping(uint => Request) public requests;
    // in newer versions of solidity values cannot be pushed inside the arrays if value contains mapping.

    // this is necessary because a mapping does not use or increment indexes automatically.
    uint public numRequests;

    constructor(uint _goal, uint _deadline) {
        goal = _goal;
        deadline = block.timestamp + _deadline; // we will be passing deadline in seconds.
        minimumContribution = 100 wei;
        admin = msg.sender;
    }

    event ContributeEvent(address _sender, uint _value);
    event CreateRequestEvent(string _description, address _recipient, uint _value);
    event MakePaymentEvent(address _recipient, uint _value);

    function contribute() public payable {
        require(block.timestamp < deadline, "Deadline has passed");
        require(msg.value >= minimumContribution, "Minimum contribution not met");

        if(contributors[msg.sender] == 0) {
            noOfContributors++;
        }

        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;

        emit ContributeEvent(msg.sender, msg.value);
    }

    receive() payable external {
        contribute();
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getRefund() public {
        require(
            block.timestamp > deadline && raisedAmount < goal,
            "Cannot get refund."
        );
        require(contributors[msg.sender] > 0,"You have not donated anything"); //means he has some balance so he can get refund.

        // we have already declared variable so we can use them
        address payable reciepient = payable(msg.sender);
        uint value = contributors[msg.sender];
        reciepient.transfer(value);

        // if recipient and value variable is not declared
        // payable(msg.sender).transfer(contributors[msg.sender]);

        contributors[msg.sender] = 0;
    }

    modifier OnlyAdmin() {
        require(msg.sender == admin, "only admin can perform this action");
        _;
    }

    function createRequests(
        string memory _description,
        address payable _recipient,
        uint _value
    ) public OnlyAdmin {
        // we cannot use memory because struct contains nesting mapping -
        // so it must be declared in a storage.
        Request storage newRequest = requests[numRequests];
        numRequests++;

        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;

        emit CreateRequestEvent(_description, _recipient, _value);
    }

    function voteRequest(uint _requestNo) public {
        // means you must contribure some money to the contract.
        // creating requests and contribure are different things.
        require(contributors[msg.sender] > 0, "You must be contributor to vote");

        Request storage thisRequest = requests[_requestNo];

        require(thisRequest.voters[msg.sender] == false, "You have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public OnlyAdmin {
        require(raisedAmount >= goal, "Goal is not yet reached");
        Request storage thisRequest = requests[_requestNo];
        require(
            thisRequest.completed == false,
            "The request has been completed"
        );
        require(
            thisRequest.noOfVoters > noOfContributors/2,
            "voting percent should be greate than 50%"
        );
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;

        emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);
    }
}