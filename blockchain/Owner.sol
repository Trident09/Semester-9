// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner {
    
    address private owner;
    string private data;
    
    event OwnershipTransferred(address indexed previous, 
                               address indexed newOwner);
    event DataUpdated(string oldData, string newData);
    
    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), owner);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call");
        _;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function updateData(string memory newData) public onlyOwner {
        string memory oldData = data;
        data = newData;
        emit DataUpdated(oldData, newData);
    }
    
    function getData() public view returns (string memory) {
        return data;
    }
    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}