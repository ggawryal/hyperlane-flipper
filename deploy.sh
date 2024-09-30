#!/bin/bash
source .env
forge script --chain=$SEPOLIA_DOMAIN ./script/Counter.s.sol --rpc-url $SEPOLIA_URL --broadcast -vvvv --account $1 > counter_deploy.log
COUNTER_SEPOLIA_ADDRESS=$(cat counter_deploy.log | grep 'new Counter@' -m 1 | cut -d @ -f 2 | tr -d '[:space:]')
echo $COUNTER_SEPOLIA_ADDRESS
