// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Keccak256

contract hashTest {

mapping(uint => address) public idToAddress; // id映射到地址

    function hash(uint _num, string memory _string, address _addr) public pure returns (bytes32) {
        return keccak256(abi.encode(_num, _string, _addr));
    }


}