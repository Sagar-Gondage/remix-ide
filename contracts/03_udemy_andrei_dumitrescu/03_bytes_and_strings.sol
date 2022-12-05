// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract BytesAndStrings{
    bytes public b1 = "abc";
    string public s1 = "abc";

    function addElement() public {
        // you can push characters in bytes
        b1.push("d");

        /*x
        you cannot push characters in string
        s1.push("d");
        */
    }

    // you can get the specific index of bytes.
    // you cannot the specific index of string.
    function getElement(uint i) public view returns(bytes1) {
        return b1[i];
    }

    // you can get the length of bytes.
    // you cannot get the length of string.
    function getLength() public view returns(uint) {
        return b1.length;
    }
}