// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";

error Unauthorized();

event Set(uint32 origin, bytes32 indexed sender, uint256 oldValue, uint256 newValue);

contract Counter {
    uint256 public number;
    address public immutable owner;
    uint32[] public allowedOriginDomains;
    address public immutable mailbox;

    constructor(address mailbox_) {
        owner = msg.sender;
        mailbox = mailbox_;
        number = 0;
    }

    function addAllowedOriginDomain(uint32 originDomain) external onlyOwner {
        allowedOriginDomains.push(originDomain);
    }

    function removeAllowedOriginDomain(uint32 originDomain) external onlyOwner {
        for (uint256 i = 0; i < allowedOriginDomains.length; i++) {
            if (allowedOriginDomains[i] == originDomain) {
                allowedOriginDomains[i] = allowedOriginDomains[allowedOriginDomains.length - 1];
                allowedOriginDomains.pop();
                return;
            }
        }
    }

    function handle(uint32 origin, bytes32 sender, bytes calldata message) external onlyMailbox {
        require(isAllowedOrigin(origin), "Incorrect origin chain domain");
        uint256 newNumber = abi.decode(message, (uint256));
        emit Set(origin, sender, number, newNumber);
        number = newNumber;
    }

    function isAllowedOrigin(uint32 origin) public view returns (bool) {
        for (uint256 i = 0; i < allowedOriginDomains.length; i++) {
            if (allowedOriginDomains[i] == origin) {
                return true;
            }
        }
        return false;
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
