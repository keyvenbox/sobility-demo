// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "./IERC20.sol";

contract ERC20 is IERC20 {

    // 账户余额
    mapping(address => uint256) public override balanceOf;

    // 授信额度 （调用者、授信账户、额度）
    mapping(address => mapping(address => uint256)) public override allowance;

    // 代币总供给
    uint256 public override totalSupply;

    // 代币名称
    string public name;
    // 代币符号
    string public symbol;
    // 小位位数
    uint8 public decimals = 18; 

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function transfer(address to, uint256 amount) external override returns(bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    /**
     * @dev 调用者账户给`spender`账户授权 `amount`数量代币。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Approval} 事件.

        函数	        调用者	    关键参数	影响的存储
        approve	        代币拥有者	spender	    allowance[msg.sender][spender]
        transferFrom	被授权者	from	    allowance[from][msg.sender]
     */
    function approve(address spender, uint256 amount) external override returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Transfer} 事件.
     */
    function transferFrom(address from, address to, uint256 amount) external override returns(bool) {
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    /**
     * 铸造代币函数
     */
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    /**
     * 销毁函数   
     */
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}
