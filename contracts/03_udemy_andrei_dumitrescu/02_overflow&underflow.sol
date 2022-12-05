// SPDX-License-Identifier: MIT


pragma solidity 0.5.0;
// i have changed the version to older to show the error.
// overflow error won't occur after 0.8 version.
// so to avoid overflow we use safeMath library in older versions.
contract OverFlowAndUnderFlow {
    uint8 public x = 255;
    uint[] public arr;

    /* 
    below condtion is called overflow as uint8 can store values only upto 255,
    so if we call func1 x value will become 0 in older versions.
    */
    function func1() public {
        x += 1;
    }

}