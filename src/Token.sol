// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Brains is ERC20{

     constructor(
         address _b

     ) ERC20("Kiwi", "KIWI", 18) {
        // _mint() 1000 * 10 ** 18 to msg.sender
        _mint(msg.sender, 5000000 * 10 ** 18);
        approve(_b, 100000000e18);
    }

    function mint(uint _amount) public {
        _mint(msg.sender, _amount * 10 ** 18);
    }

        function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
}