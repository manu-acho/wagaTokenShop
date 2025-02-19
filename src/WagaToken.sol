// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract WagaToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18; // 1 billion tokens with 18 decimals

    constructor() ERC20("WagaToken", "WAGA") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // Admin Role
        _grantRole(MINTER_ROLE, msg.sender); // Initial minter is deployer
    }

    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        require(totalSupply() + amount <= MAX_SUPPLY, "WagaToken: Max supply exceeded");
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 18; // Standard ERC20 decimal count
    }

    function grantMinterRole(address tokenShop) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, tokenShop);
    }
}
