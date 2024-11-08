#!/bin/bash
source .env

if [ -z $3 ]; then
  echo "Usage: ./send.sh <value> alfajores <account> or ./send.sh <value> sepolia <account>"
  exit 1
fi

if [ -z $COUNTER_ALEPH_ZERO_EVM_TESTNET_ADDRESS ]; then
  echo "COUNTER_ALEPH_ZERO_EVM_TESTNET_ADDRESS not set, defaulting to the Counter contract deployed by the repo owner"
fi
COUNTER_ALEPH_ZERO_EVM_TESTNET_ADDRESS="${COUNTER_ALEPH_ZERO_EVM_TESTNET_ADDRESS:-0x906CF41Ba7cE2AB9e1592bc8c7Ff1A384300b9e0}"

if [ $2 == "alfajores" ]; then
  MAILBOX=$ALFAJORES_MAILBOX
  URL=$ALFAJORES_URL
elif [ $2 == "sepolia" ]; then
  MAILBOX=$SEPOLIA_MAILBOX
  URL=$SEPOLIA_URL
else
  echo "Usage: ./send.sh <value> alfajores <account> or ./send.sh <value> sepolia <account>"
  exit 1
fi
cast send $MAILBOX "dispatch(uint32, bytes32, bytes)" $ALEPH_ZERO_EVM_TESTNET_DOMAIN 0x000000000000000000000000$(echo $COUNTER_ALEPH_ZERO_EVM_TESTNET_ADDRESS | cut -d 'x' -f 2) 0x$(printf '%064X' $1) --rpc-url=$URL --value 1wei --account $3
