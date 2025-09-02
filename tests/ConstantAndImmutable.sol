// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable
contract Constant {
    // constant变量必须在声明的时候初始化，之后不能改变
    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0xAA";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

}

contract Immutable {
    // immutable变量可以在constructor里初始化，之后不能改变
    uint256 public immutable IMMUTABLE_NUM = 9999999999;

    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_VALUE;
    uint256 public immutable IMMUTABLE_TEST = test();


    // 利用constructor初始化immutable变量，因此可以利用
    constructor() {
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_VALUE = block.timestamp;
    }

    function test() public pure returns(uint256) {
        uint256 x = 1;
        return x;
    } 

}