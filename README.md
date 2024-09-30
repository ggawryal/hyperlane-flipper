# Hyperlane Hello World
A simple `Counter` contract, that can be set either by its owner, or by anyone sending a message from a different, specified chain.

## Running
By default, official Mailbox contracts on Alfajores and Sepolia will be used. There's an already deployed `Counter` contract on Sepolia, which will accept only messages from Alfajores. 
It's also possible to deploy a new Counter instance - see step 2. 

1. `source .env`

2. (Optional; otherwise the predeployed Counter address will be used) Deploy the Counter contract on Sepolia: `./deploy.sh <ACCOUNT>`. For this you will need an `ACCOUNT` in `cast` keystore, with some sETH. 
After deploying, execute `export COUNTER_SEPOLIA_ADDRESS=...` - the deployed address will be printed by the script.

3. Get some CELO on Alfajores there: https://faucet.celo.org/alfajores (no special requirements), and save the seed for the account to `cast` keystore as some `<ACCOUNT>`.

4. Send message to Alfajores Mailbox:
`./send.sh <NUMBER> <ACCOUNT>`
The relayer will pick it up and bridge the message to Sepolia's mailbox, which will pass it to the Counter, and it will be set to `NUMBER`. 

5. Observe in https://explorer.hyperlane.xyz/, that your message has been bridged succesfully. Click on this transfer, then under _Destination Transaction_ click _View in block explorer_ on Sepolia - it will open Sepolia's Etherscan. Check if an event `Set(<ACCOUNT>s address, oldValue, NUBMER)` has been emitted.

## Building
`forge build`

## Unit tests
`forge test`