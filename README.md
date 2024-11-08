# Hyperlane Hello World
A simple `Counter` contract, that can be set either by its owner, or by anyone sending a message from a different, specified chain.

## Running
By default, official Mailbox contracts on Alfajores, Aleph Zero EVM Testnet, and Sepolia will be used. There's an already deployed `Counter` contract on Aleph ZERO EVM Testnet, which will accept only messages from these two domains. 
It's also possible to deploy a new Counter instance - see step 2. 

1. `source .env`

2. (Optional; otherwise the predeployed Counter address will be used) Deploy the Counter contract on Aleph: `./deploy.sh <ACCOUNT>`. For this you will need an `ACCOUNT` in `cast` keystore, with some sETH. 
After deploying, execute `export COUNTER_ALEPH_ZERO_TESTNET_EVM_ADDRESS=...` - the deployed address will be printed by the script.

3. Get some CELO on Alfajores there: https://faucet.celo.org/alfajores (no special requirements), and save the seed for the account to `cast` keystore as some `<ACCOUNT>`.

4. Send message to Alfajores Mailbox:
`./send.sh <NUMBER> alfajores <ACCOUNT>`
The relayer will pick it up and bridge the message to Aleph's mailbox, which will pass it to the Counter, and it will be set to `NUMBER`. 

5. Observe in https://explorer.hyperlane.xyz/, that your message has been bridged succesfully. Click on this transfer, then under _Destination Transaction_ click _View in block explorer_ on Aleph - it will open Aleph Zero EVM Testnet's Etherscan. Check if an event `Set(<ACCOUNT>s address, oldValue, NUBMER)` has been emitted.

Notes:
If we disallow Alfajores as the origin chain, an error will be shown in Hyperlane explorer - see [this example](https://explorer.hyperlane.xyz/message/0xb876d0e372b80b678cc34929d93f7190d8b1a3346e33cf2fdbabf0e2a8d92b23).

## Building
`forge build`

## Unit tests
`forge test`

