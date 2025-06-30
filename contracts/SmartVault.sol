// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


/**
 * @title SmartVault
 * @notice Individual Smart Vault, managed by one single owner
 */
contract SmartVault is ReentrancyGuard {
    address public immutable owner;
    uint256 public immutable maxBalance;

    bool public paused;

    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed recipient, uint256 amount);
    event Paused(bool status);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier notPaused() {
        require(!paused, "Vault is paused");
        _;
    }

    constructor(address _owner, uint _maxBalance) {
        owner = _owner;
        maxBalance = _maxBalance;
    }

    /// @notice Recieve Ether and verify max balance
    receive() external payable {
        // address(this).balance is the balance including the amount trying to receive at the moment
        require(address(this).balance <= maxBalance, "Max balance exceeded");
        require(!paused, "Vault is paused");
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Allows owner to withdraw Ether
    function withdraw(uint amount) external onlyOwner notPaused nonReentrant {
        require(address(this).balance >= amount, "Not enough balance");
        payable(owner).transfer(amount);
        emit Withdraw(owner, amount);
    }

    /// @notice Activates or deactivates emergency mode
    function setPaused(bool _paused) external onlyOwner {
        paused = _paused;
        emit Paused(_paused);
    }

    /// @notice Allows checking a vault's balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
