// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract checkMyEligibility {
    error Underaged(uint givenAge, uint requiredAge);

    uint requiredAge;

    constructor(uint _requiredAge) {
       requiredAge = _requiredAge;
    }

    function checkAge(uint _age) public view {
      if (_age < requiredAge){
         revert Underaged({
             givenAge: _age,
             requiredAge: requiredAge
          });
        }
    }
}