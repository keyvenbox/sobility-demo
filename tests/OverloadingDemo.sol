// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Overloading{

    // 函数重载
    function saySomething() public pure returns(string memory) {
        return("Noting");
    }

    function saySomething(string memory something) public pure returns(string memory) {
        return(something);
    }

    // 实参匹配（Argument Matching）
    function f(uint8 _in) public pure returns(uint8 out) {
        out = _in;
    }

    function f(uint256 _in) public pure returns(uint256 out) {
        out = _in;
    }

    function callF(uint _in) public pure returns(uint out){
        return f(_in);
    }
}