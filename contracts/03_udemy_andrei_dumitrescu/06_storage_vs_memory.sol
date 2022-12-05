// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract A {
    string[] public cities = ["nagar","pune"];

    function f_memory() public view {
        // new local memory is created and changes made in the localArray will not be -
        // affect the main state variable values utill we asign the localVariable to main variable.
        // refernce by value.
        string[] memory s1 = cities;
        s1[0] = "mumbai";
    }

    function f_storage() public {
        // chnages made in s1 will be reflexted in main mapping.
        // consider it as an value by referece.
        string[] storage s1 = cities;
        s1[0] = "delhi";
    }
}