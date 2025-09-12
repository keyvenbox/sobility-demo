// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SelectorTest {

    function transfer(address recipient, uint amount) external returns (bool) {
        return true;
    }


    function transferHash() external pure returns (bytes4) {
        return bytes4(keccak256("transfer(address,uint256)"));
    }

    function selectorF() public returns (bytes memory _bytes) {

        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(bytes4(keccak256("transferHash()"))));
        if(success) {
            _bytes =  data;
        }
    }

}