// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 导入 OpenZeppelin 的 Strings 库
import "@openzeppelin/contracts/utils/Strings.sol";


contract LibraryTest {
    // 利用using for指令
    using Strings for uint256;
    function getString1(uint256 _number) public pure returns(string memory){
        // 库合约中的函数会自动添加为uint256型变量的成员
        return _number.toHexString();
    }

    // 直接通过库合约名调用
    function getString2(uint256 _number) public pure returns(string memory) {
        return Strings.toHexString(_number);
    }

}