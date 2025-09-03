// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract EventContract {

    mapping(address => uint256) public _balances; // 定义一个映射来存储地址和余额

    // 定义交易事件
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 定义_transfer函数，执行转账逻辑
    function _transfer (
        address from,
        address to,
        uint256 amount
    ) external {
        // 在这里执行转账逻辑
        // 例如：更新余额、检查授权等
        _balances[from] = 100000000; // 给转账地址一些初始代币
        _balances[from] -= amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量

        // 触发Transfer事件
        emit Transfer(from, to, amount);
    }

    
    


}