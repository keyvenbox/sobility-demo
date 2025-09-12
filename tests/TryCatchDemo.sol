// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

//import * as Wowo from "./Yeye.sol";
// import {FallbackTest as Wowo} from "./Fallback.sol";
// import * as Wowo from "./Fallback.sol";
// import {FallbackTest} from "./Fallback.sol";
import * as a from "./Fallback.sol";

contract OnlyEven {

    constructor(uint a) {
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function onlyEven(uint256 b) external pure returns(bool success){
        // 输入奇数时revert
        require(b%2 == 0, "Ups! Reverting");
        success = true;
    }
}

contract ExternalCall {
    // 成功event
    event SuccessEvent();

    // 失败event
    event CatchEvent(string message);
    event CatchByte(bytes data);

    event Log(uint value, uint gas);

    // 声明OnlyEven合约变量
    OnlyEven even;

     // receive方法，接收eth时被触发
    receive() external payable { 
        emit Log(msg.value, gasleft());
    }

    constructor() {
        even = new OnlyEven(2);
    }

    // 在external call中使用try-catch
    function excute(uint amount) external returns(bool success) {

        try even.onlyEven(amount) returns (bool _success) {
            // call成功的情况下
            emit SuccessEvent();
            return _success; 
        } catch Error(string memory reason){
            // call不成功的情况下
            emit CatchEvent(reason);
        }
    }

    // 处理合约创建异常
    function excuteNew(uint amount) external returns(bool success) {
        try new OnlyEven(amount) returns (OnlyEven _event) {
            // call成功的情况下
            emit SuccessEvent();
            success = _event.onlyEven(amount);
        } catch Error(string memory message){
            // catch失败的 revert() 和 require()
            emit CatchEvent(message);
        } catch (bytes memory reason) {
            // catch失败的 assert()
            emit CatchByte(reason);
        }
    }


}