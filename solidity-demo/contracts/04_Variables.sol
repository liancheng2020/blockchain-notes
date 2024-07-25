// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Variables {
    string public text = "Hello";
    uint256 public num = 123;

    event LogInfo(
        uint256 indexed timestamp,
        address indexed sender,
        uint256 localVar
    );

    function doSomething() public {
        uint256 i = 456;

        uint256 timestamp = block.timestamp;
        address sender = msg.sender;

        emit LogInfo(timestamp, sender, i);
    }
}