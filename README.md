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
- 🛡️ Secure-by-design: uses OpenZeppelin's `ReentrancyGuard` to prevent reentrancy attacks and includes basic access control via `onlyOwner`.

## 🧪 Usage

This project is intended to be used and tested in **Remix IDE**. No additional framework setup is required.

Steps to test:

1. Open both `SmartVault.sol` and `VaultFactory.sol` in Remix.
2. Compile both contracts (starting with `SmartVault.sol`).
3. Deploy `VaultFactory`.
4. Use the `createVault(uint _maxBalance)` function to create a new vault.
5. Interact with your deployed vault by calling deposit (via low-level value transfer), `withdraw()`, or `setPaused()`.

## 🔒 Security Considerations

- `ReentrancyGuard` from OpenZeppelin is included to protect against reentrancy attacks.
- The withdrawal function is restricted to the vault owner.
- Vaults can be paused in emergency situations to prevent deposits or withdrawals.
- Vaults should not be interacted with directly if not created through the factory, as they won’t be tracked.

## 🧭 Future Improvements

- 🔄 **Upgradeable architecture**: The current vaults are deployed as immutable contracts. Future versions could integrate a **proxy pattern** (e.g., UUPS or Transparent Proxy) to allow for upgradable logic in deployed vaults without losing state.
- 🗂 **User interface**: A simple frontend could improve usability for non-technical users.
- 🔐 **Advanced access control**: Integration with OpenZeppelin’s `AccessControl` for role-based permissions (e.g., emergency managers).
- 🪙 **Token support**: Allow vaults to hold ERC-20 tokens, not just native Ether.

## 📜 License

This codebase is provided open-source for educational purposes. You’re free to adapt and use it for learning or as a base for more advanced applications.
