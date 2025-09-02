// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract ConstructorTest {

    address public owner; // 定义owner变量

    // 构造函数constructor 初始化合约的一些参数 
    constructor (address initialOwner){
        owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
    }

    // 修饰器（modifier）
    modifier onlyOwner {
        require(owner == msg.sender, "caller is not owner"); // 检查调用者是否为owner
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }

    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
    } 

    


}