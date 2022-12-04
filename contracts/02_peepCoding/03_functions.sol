// SPDX-License-Identifier: MIT

pragma solidity 0.8;

contract functionIntro {

    uint age = 20;
    uint public age1 = 25;

    function add(uint _x, uint _y) public pure returns(uint) {
        return _x + _y;
    }

    function changeAge() public {
        age += 1;
    }

    function getAddedAge(uint _newValue) public view returns(uint) {
				return age1+_newValue;
}

    function getAge() public view returns(uint) {
        return age;
    }

    function getAge1() public view returns(uint) {
        return age1;
    }

    function pure1(uint _a, uint _b) public pure returns(uint) {
        return _a + _b;
    }

    function getSumAge(uint number2, uint number3) public view returns(uint) {
        uint sum = age + number2 + number3;
        return sum;
    }
}

function outSide(uint _x) pure returns(uint) {
    return _x*10;
}