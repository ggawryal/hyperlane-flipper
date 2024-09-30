// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";

error Unauthorized();

event Set(bytes32 indexed sender, uint256 oldValue, uint256 newValue);

contract Counter {
    uint256 public number;
    address public immutable owner;
    uint32 public immutable originChainDomain;
    address public immutable mailbox;

    constructor(address mailbox_, uint32 originChainDomain_) {
        owner = msg.sender;
        mailbox = mailbox_;
        originChainDomain = originChainDomain_;
        number = 0;
    }

    function setNumber(uint256 newNumber) external onlyOwner {
        number = newNumber;
    }

    function handle(uint32 origin, bytes32 sender, bytes calldata message) external onlyMailbox {
        require(origin == originChainDomain, "Incorrect origin chain domain");
        uint256 newNumber = abi.decode(message, (uint256));
        emit Set(sender, number, newNumber);
        number = newNumber;
    }

    modifier onlyMailbox() {
        require(msg.sender == mailbox, "Counter: sender not mailbox");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Counter: sender not owner");
        _;
    }
}
