# SmartVault System 🏦

(work in progress) This project implements a decentralized **Smart Vault system** in Solidity, where users can create individual vault contracts to deposit and withdraw Ether securely, with a configurable **maximum balance limit**. Vaults can only be created via a central **Vault Factory**, following key Solidity design patterns and security best practices.

## 📂 Project Structure

- **VaultFactory.sol** – The main contract that lets users create new SmartVaults and keeps track of them.
- **SmartVault.sol** – The vault contract that acts as a personal Ether storage with deposit, withdrawal, and balance limit logic.

## ⚙️ Key Features

- ✅ Ether depositing via `receive()` and `payable` functions.
- 🔓 Withdrawal only by the vault owner.
- 🧱 Enforced max balance limit (`maxBalance`) per vault.
- 🏭 Factory pattern: vaults are deployed exclusively through `VaultFactory`. Vaults deployed without using the factory will be outside the mapping and won't be considered part of the system.
- 🔗 Contract-to-contract interaction between the factory and each vault.
- 🚫 Includes a fallback function to handle unexpected calls.
- 🛡️ Secure-by-design: avoids unsafe calls and includes basic safeguards.


## 🔒 Security Considerations

- Currently safe for basic use, but adding `ReentrancyGuard` is highly recommended for more advanced logic.
- For secure withdrawal patterns, consider implementing the pull payment model (withdraw pattern) instead of direct transfers.

## 📜 License

This codebase is provided open-source for educational purposes. You’re free to adapt and use it for learning or as a base for more advanced applications.


