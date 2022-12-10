// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract A {
    uint private x = 10; // only within the contract.
    uint internal y = 100; // within the contract & in derived contract.
    uint public z = 1000; // everywhere.
    string open = "no visibility";

    function Private() private pure returns(string memory) {
        return "private";
    }

    function Internal() internal pure returns(string memory) {
        return "internal";
    }

    function External() external pure returns(string memory) {
        return "external";
    }

    function Public() public pure returns(string memory) {
        return "public";
    }

    function checkVariables() public pure returns(uint) {
        // return x; // allowed.
        // return y; // allowed.
        // return z; // allowed.
        return 1;
    }

    function checkFunctions() public pure returns(string memory) {
        // return Private(); // allowed.
        // return Internal(); // allowed.
        // return External(); // THIS IS NOT ALLOWED.
        return Public(); // allowed.
    }
}

contract B is A {
//    uint a = x; // NOT ALLOWED.
    uint public a = y; // allowed.
    uint public b = z; // allowed.
    string public newOpen =  open;

    // string public functions = Private(); // NOT ALLOWED.
    string public functions = Internal(); // allowed.
    // string public functions2 = External(); // NOT ALLOWED
    string public functions3 = Public(); // allowed.
}

contract outsideContract {
    // uint b = z; // here z is undeclared because this contract does not know the 
    //existance of z.

    // creating object of contract
    // all the functions and variables of contract A are in obj.
    A obj = new A(); // this contract deploys contract A .but it is private
    A public contract_a = new A(); // this is public. // it gives some address.
    uint public a = obj.z();

    function outsideCaller() public view returns(string memory) {
        return obj.External();
    }
}