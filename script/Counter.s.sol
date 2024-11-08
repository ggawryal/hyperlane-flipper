// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function run() public {
        require(vm.envUint("ALFAJORES_DOMAIN") <= type(uint32).max, "Domain must be an uint32");
        require(vm.envUint("SEPOLIA_DOMAIN") <= type(uint32).max, "Domain must be an uint32");

        uint32 alfajores_domain = uint32(vm.envUint("ALFAJORES_DOMAIN"));
        uint32 sepolia_domain = uint32(vm.envUint("SEPOLIA_DOMAIN"));

        address mailbox = vm.envAddress("ALEPH_ZERO_EVM_TESTNET_MAILBOX");

        vm.startBroadcast();

        counter = new Counter(mailbox);
        counter.addAllowedOriginDomain(alfajores_domain);
        counter.addAllowedOriginDomain(sepolia_domain);

        vm.stopBroadcast();
    }
}
