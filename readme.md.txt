This contract can be used as an addon to an existing token contract, to faciliate mass sendouts of tokens tested to up to 80-90 Ethereum addresses per batch.
This is useful for airdrops, bounty payouts, or just a general third party token holder/sender.

The contract can hold the ERC20 Tokens from the token contract that is stored, and will only respond to the owner of the contract (which by default is the person who deploys/creates it, but can be transferred to any ETH address).


When The contract is destroyed, tokens are sent back to the current owner of the contract.

To Get Started:

Line 3: Either import the token contract code in your contract editor or replace this line with inline token functions.
Line 15: Change "0xTOKENADDRESS" to the ERC20 token's contract address.
Line 32: Change 10^18  - change the 18 to whatever decimal that your ERC20 Token uses in this example the token used 18 decimals


Note: In our example we used 10^18 (18 decimals) for our token so that when we send it using this code

100000000000000000 = 1 of our ERC20 token 

