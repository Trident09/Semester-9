// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserBalance {
    
    mapping(address => uint256) private balances;
    
    event BalanceUpdated(address indexed user, uint256 newBalance);
    
    function setBalance(uint256 amount) public {
        balances[msg.sender] = amount;
        emit BalanceUpdated(msg.sender, amount);
    }
    
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
    
    function getBalanceOf(address user) public view returns (uint256) {
        return balances[user];
    }
    
    function addBalance(uint256 amount) public {
        balances[msg.sender] += amount;
        emit BalanceUpdated(msg.sender, balances[msg.sender]);
    }
    
    function transfer(address recipient, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Invalid recipient");
        
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        
        emit BalanceUpdated(msg.sender, balances[msg.sender]);
        emit BalanceUpdated(recipient, balances[recipient]);
    }
}