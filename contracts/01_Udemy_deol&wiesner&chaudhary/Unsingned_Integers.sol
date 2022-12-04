// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract ExampleUnit {
    // uint can also be written as uint256 which means it can store the numbers 
    // between the range of 0-(2^256)-1
    uint public myUint;

    uint8 public myuint8; // can store number between 0-(2^8)-1 means from 0-255
    uint8 public myuintNew8 = 250; // press in increment button and click on myuintNew8 button
    // value cannot be increased above 255
    // we can set number like 2**4, means setting default value to 16

    int public myInt = -10; // -2^128 to + (2^128)-1

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function setMyUint8(uint8 _myUint8) public {
        myuint8 = _myUint8;
    }

    function incrementMyUintNew8() public {
        myuintNew8++;
    }

    function decrementMyUintNew8() public {
        myUint--;
    }
    // will fail to decreament because uint value number cannot be below 0 

    function incrementInt() public {
        myInt++;
    }

   
}