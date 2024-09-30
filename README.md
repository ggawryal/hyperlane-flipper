# Running

1. `source .env`

1. (Optionally - otherwise predeployed Counter address will be used) deploy the Counter contract on Sepolia: `./deploy.sh <ACCOUNT>`. For this you will need an `ACCOUNT` in `cast` keystore, with some sETH. 
After deploying, execute `export COUNTER_SEPOLIA_ADDRESS=...` - the deployed address will be printed by the script.
 
2. Send message to Alfajores Mailbox:
`./send.sh <NUMBER> <ACCOUNT>`
This will relay the message to Sepolia's mailbox, then pass it to the Counter, which will be set to the given number.

# Building

`forge build`

# Deploying contracts

First, we have to deploy either 

## Already deployed Mailbox on Aleph EVM Testnet

