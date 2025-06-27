// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SmartVault is ReentrancyGuard {
    address public owner;
    uint public maxBalance;

    constructor(address _owner, uint _maxBalance) {
        owner = _owner;
        maxBalance = _maxBalance;
    }

    receive() external payable {
        // address(this).balance is the balance including the amount trying to receive at the moment
        require(address(this).balance <= maxBalance, "Max balance exceeded");
    }

    function withdraw(uint amount) external nonReentrant {
        require(msg.sender == owner, "Not owner");
        require(address(this).balance >= amount, "Not enough balance");
        payable(owner).transfer(amount);
    }
}
