// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function run() public {
        require(vm.envUint("ALFAJORES_DOMAIN") <= type(uint32).max, "Domain must be an uint32");
        uint32 originChainDomain = uint32(vm.envUint("ALFAJORES_DOMAIN"));
        address mailbox = vm.envAddress("SEPOLIA_MAILBOX");

        vm.startBroadcast();

        counter = new Counter(mailbox, originChainDomain);

        vm.stopBroadcast();
    }
}
