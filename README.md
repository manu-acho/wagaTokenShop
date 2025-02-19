# WagaToken & TokenShop Smart Contract Suite

## Overview
This project consists of a **utility token (WagaToken)** and a **TokenShop smart contract** that enables users to purchase WagaTokens using ETH, based on the real-time ETH/USD price from Chainlink's oracle.

## Contracts
### 1️⃣ **WagaToken.sol**
- An **ERC20 token** with `MINTER_ROLE` controlled minting.
- Uses **OpenZeppelin’s AccessControl** to grant/revoke minter permissions.
- Default admin can grant the **TokenShop contract** the `MINTER_ROLE`.
- **Fixed 2 decimal places** for easy pricing calculations.

### 2️⃣ **TokenShop.sol**
- Accepts **ETH** and mints **WagaTokens** for users.
- Uses **Chainlink’s ETH/USD price feed** to determine exchange rates.
- **Only the contract owner** can withdraw ETH from sales.
- Integrated with **OracleLib** for stale price protection.

### 3️⃣ **OracleLib.sol**
- Fetches **secure & fresh price data** from Chainlink.
- Ensures **price feed is not stale** before use.

## Deployment Steps
### 1️⃣ Deploy WagaToken
```sh
forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/WagaToken.sol:WagaToken
```
### 2️⃣ Deploy TokenShop
```sh
forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/TokenShop.sol:TokenShop --constructor-args <WAGATOKEN_ADDRESS> <CHAINLINK_PRICE_FEED>
```
### 3️⃣ Grant `MINTER_ROLE` to TokenShop
```sh
cast send <WAGATOKEN_ADDRESS> "grantMinterRole(address)" <TOKENSHOP_ADDRESS> --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```
### 4️⃣ (Optional) Revoke `MINTER_ROLE` from deployer for security
```sh
cast send <WAGATOKEN_ADDRESS> "revokeRole(bytes32,address)" $(cast keccak "MINTER_ROLE") <DEPLOYER_ADDRESS> --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```

## Testing
Run unit tests with Foundry:
```sh
forge test
```

## Future Enhancements
- Add **burning function** for token buybacks.
- Implement **referral rewards** in TokenShop.
- Expand **multi-chain support** via cross-chain bridges.

## License
This project is licensed under **MIT License**.

---

🚀 **Built for seamless token sales with real-time price feeds!**

