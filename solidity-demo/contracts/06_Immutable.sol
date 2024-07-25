// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UNIT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UNIT = _myUint;
    }
}