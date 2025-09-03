// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


interface Base {
    function getFirstName() external pure returns (string memory);

    function getLastName() external pure returns (string memory);
}


contract BaseImpl is Base {

    function  getFirstName() external pure returns (string memory){
        return "BameImpl first name";
    }

    function getLastName() external pure returns (string memory){
        return "BameImpl last name";
    }

}
