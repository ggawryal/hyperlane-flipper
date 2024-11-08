// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import "forge-std/console.sol";

contract CounterTest is Test {
    Counter public counter;
    address constant TEST_ACCOUNT = 0x1234567890AbcdEF1234567890aBcdef12345678;

    function setUp() public {
        counter = new Counter(TEST_ACCOUNT);
        counter.addAllowedOriginDomain(1);
    }

    function testFuzz_handle_from_mailbox(uint256 x) public {
        vm.prank(TEST_ACCOUNT);
        counter.handle(1, 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef, abi.encode(uint256(x)));
        assertEq(counter.number(), x);
    }

    function test_handle_non_mailbox() public {
        vm.prank(vm.addr(1));
        vm.expectRevert("Counter: sender not mailbox");
        counter.handle(1, 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef, abi.encode(uint256(54)));
    }

    function test_handle_incorrect_domain() public {
        vm.prank(TEST_ACCOUNT);
        vm.expectRevert("Incorrect origin chain domain");
        counter.handle(5, 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef, abi.encode(uint256(54)));
    }

    function test_add_remove_allowed_origins() public {
        counter.addAllowedOriginDomain(2);
        counter.addAllowedOriginDomain(3);
        counter.addAllowedOriginDomain(4);
        counter.removeAllowedOriginDomain(3);
        assertEq(counter.isAllowedOrigin(2), true);
        assertEq(counter.isAllowedOrigin(3), false);
        assertEq(counter.isAllowedOrigin(4), true);
    }
}
