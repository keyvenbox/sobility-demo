// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "./IERC20.sol";

contract Airdrop {

    function getSum(uint256[] calldata _array) public pure returns(uint256) {

        uint256 sum = 0;
        for (uint256 i = 0; i < _array.length; i++) {
            sum += _array[i];
        }
        return sum;
    }

    function multiTransferToken(address _token, address[] calldata _addresses, uint256[] calldata _amounts) external {

        // Check: The length of _addresses array should be equal to the length of _amounts array
        require(_addresses.length == _amounts.length, " the length of _addresses must equal the length of _amounts!");

        IERC20 token = IERC20(_token);
        uint256 allowance = token.allowance(msg.sender, address(this));
        uint256 sum = getSum(_amounts);
        // Check: The authorized amount of tokens should be greater than or equal to the total amount of airdropped tokens
        require(allowance >= sum , "Need Approve ERC20 token");

        for (uint i = 0; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }


    /// Transfer ETH to multiple addresses
    function multiTransferETH(address payable[] calldata _addresses, uint256[] calldata _amounts) public payable {
        // Check: _addresses and _amounts arrays should have the same length
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        // Calculate total amount of ETH to be airdropped
        uint _amountSum = getSum(_amounts);
        // Check: transferred ETH should equal total amount
        require(msg.value == _amountSum, "Transfer amount error");
        // Use a for loop to transfer ETH using transfer function
        for (uint256 i = 0; i < _addresses.length; i++) {
            _addresses[i].transfer(_amounts[i]);
        }
    }


}


