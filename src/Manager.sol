// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "./interfaces/ICore.sol";
import "./interfaces/IERC20.sol";

contract ContractB {

    event Passed(bytes data );
    // Manager

    // lets make a storage of how much a payer has sent in added amouts as liquidityDelta ;)
    struct TxData {
        address payer;
        uint amount0;
        uint amount1;
    }

    mapping(address => uint) public donations;

    function callBackDonate() public {

    }

    function directDonation(
        uint _amount0,
        uint _amount1,
        address _token1,
        address _token0,
        address _core
    ) public {
        // should check for balances, but whatever 
        uint liquidityDelta = _amount0 + _amount1;
        bytes memory data = abi.encode(msg.sender, _amount0, _amount1);
        ICore(_core).createPosition(
            liquidityDelta,
            data,
            // abi.encodePacked(keccak256(data))          // wow cool ttrick ;)
            _token0,
            _token1
        );

        IERC20(_token1).transferFrom(msg.sender, _core, _amount1);
        IERC20(_token0).transferFrom(msg.sender, _core, _amount0);

        emit Passed(data);
    }

    //Helper:   
    function hashingOutput(uint _amount0, uint _amount1) public view returns(bytes memory answer) {     // This is a dynamic array of unknown slot number of byte arrays, therefore "memory" duh.
        answer = abi.encode(msg.sender, _amount0, _amount1);
    }


    function hashingForContractA_Key(address _add, uint _amount0, uint _amount1) public pure returns(bytes32 answer) {    // since we know the size of the bytes before hand we dont need the "memory" keyword
        answer = keccak256(abi.encodePacked(_add, _amount0, _amount1));
    }
}