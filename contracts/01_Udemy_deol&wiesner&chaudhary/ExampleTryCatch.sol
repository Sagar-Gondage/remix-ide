// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract WillThrow {
    error NotAllowedError(string);
    function aFunction() public pure {
        // require(false, "Error Message"); // to get the try catch block
        // assert(false); // to get the panic data
        revert NotAllowedError("You are not allowed"); // to get the low level data
    }
}

contract ErrorHandling {
    event ErrorLoggin(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);
    function catchTheError() public {
       WillThrow will = new WillThrow();
        try will.aFunction() {
            // add code here if it works
        } catch Error(string memory reason) {
            emit ErrorLoggin(reason);
        } catch Panic(uint errorcode) {
            emit ErrorLogCode(errorcode);
        } catch (bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }
    }
}