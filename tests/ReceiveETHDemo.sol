// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveETH{

    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);

    // receive方法，接收eth时被触发
    receive() external payable { 
        emit Log(msg.value, gasleft());
    }

    // 返回合约ETH余额
    function getBalance() view public returns (uint) {
        return address(this).balance;
    }

}

/**
call没有gas限制，最为灵活，是最提倡的方法；
transfer有2300 gas限制，但是发送失败会自动revert交易，是次优选择；
send有2300 gas限制，而且发送失败不会自动revert交易，几乎没有人用它。
*/

// 发送ETH合约 ，三种方法向ReceiveETH合约发送ETH
contract SendETH{

    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable {}

    // receive方法，接收eth时被触发
    receive() external payable { }

    // 1、 transfer 用法是接收方地址.transfer(发送ETH数额)
    function transferETH(address payable _to, uint256 amount) external payable {
        _to.transfer(amount);
    }

    error SendFailed(); // 用send发送ETH失败error

    // 2、send()发送ETH
    function sendETH(address payable _to, uint256 amount) external payable {
        // 处理下send的返回值，如果失败，revert交易并发送error
        bool success = _to.send(amount);
        if (!success) {
            revert SendFailed();
        }
    }

    error CallFailed();

    // 3. call()发送ETH
    function call(address payable _to, uint256 amount) external payable {
       (bool success, ) = _to.call{value: amount} ("");
        // 处理下call的返回值，如果失败，revert交易并发送error
        if (!success) {
            revert CallFailed();
        }
    }

}