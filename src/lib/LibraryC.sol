// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

library LibraryC {

    struct Info {
        address payer;
        address token0;
        address token1;
        uint amount0;
        uint amount1;
        uint128 liquidity;
    }
    // mapping ((payer, amount0, amount1) => LibraryC.Info) ;)

    function get(
        mapping(bytes32 => LibraryC.Info) storage self,
        address payer,
        uint amount0,
        uint amount1
    ) internal view returns(LibraryC.Info storage txInfo){  // fuck space rn xd
        txInfo = self[
            keccak256(abi.encodePacked(
                payer,
                amount0,
                amount1
            ))
        ];
    }

    function add(
        Info storage self,
        uint128 liquidityDelta
    ) internal {
        self.liquidity += liquidityDelta;
    }
}