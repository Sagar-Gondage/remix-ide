// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// create a messagner which will check if sender is owner or not
// if yes then update the message and inc the counter
contract ExampleConstructor {
   
   uint public changeCounter;

   address public owner;

   string public theMessage;

   constructor () {
       owner = msg.sender;
   }

   function updateTheMessage(string memory _newMessage) public {
       if(msg.sender == owner) {
           theMessage = _newMessage;
           changeCounter++;
       }
   }
      
}