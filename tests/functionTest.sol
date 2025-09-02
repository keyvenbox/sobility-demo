// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FunctionTypes {

    uint256 public _number = 100;

    function add() external {
        _number = _number + 1;
    }

    // pure: 纯纯牛马
    function addPure(uint256 _number1) external pure returns (uint256 new_number){
        return _number1 + 1;
    }

    // view: 看客
    function addView() external view returns (uint256 new_number){
        new_number = _number + 1;
    }

    // internal: 内部函数
    function minus() internal {
        _number = _number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }

    // payable: 递钱，能给合约支付eth的函数
    function minuxPayable() external payable returns(uint256 balance) {
        minus();
        balance = address(this).balance;
    }

    // 返回多个变量
    function returnMultiple() external pure returns (uint256, bool, uint256[3] memory) {
        return (1, true, [uint256(1),2,5]);
    }

    // 命名式返回
    function returnNamed() public pure returns (uint256 _number2, bool _bool, uint256[3] memory _array) {
        _number2 = 1;
        _bool = true;
        _array = [uint256(1),2,5];
        // 支持return 返回
        //return (1,true, [uint256(1),2,5]);
    }

    // 读取返回的值，解构式赋值
    function returnRead() public pure {
        uint256 _numberR;
        bool _bool; 
        bool _bool2; 
        uint256[3] memory _array;

        (_numberR, _bool, _array) = returnNamed();
        // 读部分值
        (, _bool2,) = returnNamed();
    }


}