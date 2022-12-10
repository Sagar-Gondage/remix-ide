// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract A {
    address public OwnerA;
    constructor(address eoa) { // eoa => externally owned account.
        OwnerA = eoa;
    }
}

contract Creator {
    address public ownerCreator;
    A[] public deployedA;

    constructor() {
        ownerCreator = msg.sender;
    }

    function deployA() public {
        A new_A_address = new A(msg.sender);
        deployedA.push(new_A_address);
    }
}