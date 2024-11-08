#!/bin/bash
source .env
forge script --chain=$ALEPH_ZERO_EVM_TESTNET_DOMAIN ./script/Counter.s.sol --rpc-url $ALEPH_ZERO_EVM_TESTNET_URL --broadcast -vvvv --account $1 > counter_deploy.log
COUNTER_ALEPH_ADDRESS=$(cat counter_deploy.log | grep 'new Counter@' -m 1 | cut -d @ -f 2 | tr -d '[:space:]')
echo $COUNTER_ALEPH_ADDRESS
