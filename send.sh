#!/bin/bash
source .env
if [ -z $COUNTER_SEPOLIA_ADDRESS ]; then
  echo "COUNTER_SEPOLIA_ADDRESS not set, defaulting to the Counter contract deployed by the repo owner"
fi

COUNTER_SEPOLIA_ADDRESS="${COUNTER_SEPOLIA_ADDRESS:-0x2C10f9E3dE063f878dAF0E2533b48a81fFaeA136}"
cast send $ALFAJORES_MAILBOX "dispatch(uint32, bytes32, bytes)" $SEPOLIA_DOMAIN 0x000000000000000000000000$(echo $COUNTER_SEPOLIA_ADDRESS | cut -d 'x' -f 2) 0x$(printf '%064X' $1) --rpc-url=$ALFAJORES_URL --value 1wei --account $2
