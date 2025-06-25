// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SmartVault {
    address public owner;
    uint public maxBalance;

    constructor(address _owner, uint _maxBalance) {
        owner = _owner;
        maxBalance = _maxBalance;
    }

    receive() external payable {
        require(address(this).balance <= maxBalance, "Max balance exceeded");
    }

    function withdraw(uint amount) external {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(amount);
    }
}
