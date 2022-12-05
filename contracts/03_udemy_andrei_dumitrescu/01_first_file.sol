// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract FirstFile {
    int public value;

    function setValue(int _value) public {
        value = _value;
    }
}