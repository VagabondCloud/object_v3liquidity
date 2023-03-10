// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface ICore {
    function createPosition(
        uint liquidityDelta, //lets say the addition of the amounts of both tokens becomes the liquidityDelta ;) * using a manager contract
        bytes calldata data,
        address _token0,
        address _token1
    ) external; 
}