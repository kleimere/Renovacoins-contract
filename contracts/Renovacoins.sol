// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Renovacoins (RVC)
 * @dev Token construido con las mejores prácticas del ecosistema Ethereum.
 * - Suministro fijo de 100 millones
 * - Funciones profesionales: Burnable, Capped, Pausable, Permit
 * - Sin blacklist, sin mint infinito
 */
contract Renovacoins is ERC20, ERC20Burnable, ERC20Permit, ERC20Capped, Pausable, Ownable {
    constructor()
        ERC20("Renovacoins", "RVC")
        ERC20Permit("Renovacoins")
        ERC20Capped(100_000_000 * 10 ** decimals())
    {
        _mint(msg.sender, 100_000_000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Capped)
    {
        super._update(from, to, value);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
