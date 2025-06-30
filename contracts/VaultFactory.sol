// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SmartVault.sol";

/**
 * @title VaultFactory
 * @notice Multiuser Smart Vault Factory
 */
contract VaultFactory {
    // Allows one user to have multiple vaults
    mapping(address => address[]) public userVaults;

    event VaultCreated(address owner, address vaultAddress, uint256 maxBalance);

    /// @notice Creates a new SmartVault for the user
    function createVault(uint _maxBalance) external {
        SmartVault newVault = new SmartVault(msg.sender, _maxBalance);
        userVaults[msg.sender].push(address(newVault));
        emit VaultCreated(msg.sender, address(newVault), _maxBalance);
    }

    /// @notice Returns the balance of one user by its index
    function getVaultBalance(address user, uint256 index) external view returns (uint256) {
        require(index < getVaultCount(user), "Invalid index");
        SmartVault vault = SmartVault(payable(userVaults[user][index]));
        return vault.getBalance();
    }

    /// @notice Returns the amount of vaults that a user owns
    function getVaultCount(address user) public view returns (uint256) {
        return userVaults[user].length;
    }
}
