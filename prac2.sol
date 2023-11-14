// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract MyBank {
    mapping(address => uint) private _balances;
    address public owner;
    event LogDepositMade(address accountHolder, uint amount);
    event LogWithdrawalMade(address accountHolder, uint amount);

    constructor() {
        owner = msg.sender;
        _balances[msg.sender] = 1000; // Initialize the owner's balance with 1000
        emit LogDepositMade(msg.sender, 1000);
    }
    function deposit() public payable returns (uint) {
        require(msg.sender != address(0), "Invalid sender address");
        require(msg.value > 0, "Deposit amount must be greater than 0");
        _balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return _balances[msg.sender];
    }
    function withdraw(uint withdrawAmount) public returns (uint) {
        require(msg.sender != address(0), "Invalid sender address");
        require(_balances[msg.sender] >= withdrawAmount, "Insufficient balance");
        require(withdrawAmount > 0, "Withdraw amount must be greater than 0");
        _balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
        emit LogWithdrawalMade(msg.sender, withdrawAmount);
        return _balances[msg.sender];
    }
    function viewBalance() public view returns (uint) {
        return _balances[msg.sender];
    }
}
