// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    
    // State variables
    string public message;
    uint256 public counter;
    address public owner;
    
    // Events
    event MessageUpdated(string newMessage);
    event CounterIncremented(uint256 newValue);
    
    // Constructor
    constructor(string memory initialMessage) {
        message = initialMessage;
        counter = 0;
        owner = msg.sender;
    }
    
    // Update message
    function updateMessage(string memory newMessage) public {
        message = newMessage;
        emit MessageUpdated(newMessage);
    }
    
    // Increment counter
    function incrementCounter() public {
        counter += 1;
        emit CounterIncremented(counter);
    }
    
    // Get contract info
    function getInfo() public view returns (
        string memory, 
        uint256, 
        address
    ) {
        return (message, counter, owner);
    }
    
    // Reset counter (owner only)
    function resetCounter() public {
        require(msg.sender == owner, "Only owner");
        counter = 0;
    }
}