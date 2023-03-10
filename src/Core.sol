// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "./interfaces/IERC20.sol";
import "./lib/LibraryC.sol";
import "./Manager.sol";
import "./interfaces/ICallback.sol";

contract ContractA {
    using LibraryC for mapping(bytes32 => LibraryC.Info);
    using LibraryC for LibraryC.Info;

    mapping(bytes32 => LibraryC.Info) public positions;

    function createPosition(
        uint liquidityDelta, //lets say the addition of the amounts of both tokens becomes the liquidityDelta ;) * using a manager contract
        bytes calldata data,
        address _token0,
        address _token1
    ) public {
        require(liquidityDelta > 0, "To little liquidity");
        ContractB.TxData memory Tx = abi.decode(data, (ContractB.TxData));

        // Line 20 gets Manager tx Data & stores it in Tx.
        LibraryC.Info storage newPosition = positions.get(
            Tx.payer,
            Tx.amount0,
            Tx.amount1
        );
        // This gets the struct, bound to the current storage's mapping "positions" key (Tx.payer, Tx.amount0, Tx.amount1). ;)

        newPosition.add(uint128(liquidityDelta));

        // very bad implementing, but just 4 testing
        newPosition.payer = Tx.payer;
        newPosition.token0 = _token0;
        newPosition.token1 = _token1;
        newPosition.amount0 = Tx.amount0;
        newPosition.amount1 = Tx.amount1;
        //liquidity was added by .add() function.
    }
}