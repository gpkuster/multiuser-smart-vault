// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SmartVault.sol";

contract VaultFactory {
    mapping(address => address[]) public userVaults;

    function createVault(uint _maxBalance) external {
        SmartVault newVault = new SmartVault(msg.sender, _maxBalance);
        userVaults[msg.sender].push(address(newVault));
    }
}
