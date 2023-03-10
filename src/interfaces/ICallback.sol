// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

interface ICallback {
    function donationCallback(int256 amount0, int256 amount1, bytes calldata data) external;
}