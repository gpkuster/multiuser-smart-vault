// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SmartVault.sol";

contract VaultFactory {
    // allows one user to have multiple vaults
    mapping(address => address[]) public userVaults;

    event VaultCreated(address owner, address vaultAddress, uint256 maxBalance);

    function createVault(uint _maxBalance) external {
        SmartVault newVault = new SmartVault(msg.sender, _maxBalance);
        userVaults[msg.sender].push(address(newVault));
        emit VaultCreated(msg.sender, address(newVault), _maxBalance);
    }
}
