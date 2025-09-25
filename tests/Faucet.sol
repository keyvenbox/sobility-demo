// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "./IERC20.sol";

// 当人渴的时候，就要去水龙头接水；当人想要免费代币的时候，就要去代币水龙头领。代币水龙头就是让用户免费领代币的网站/应用。
contract Faucet {

    uint256 public amountAllowed = 100; // 每次领100单位代币
    address public tokenContract; // token合约地址
    mapping(address => bool) public requestAddress; // 记录领取过代币的地址

    event SendToken(address indexed Receiver, uint256 amount);

    constructor (address tokenAddr) {
        tokenContract = tokenAddr;
    }

    function requestToken() external {
        require(!requestAddress[msg.sender], "You already claimed your tokens!");
        IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
        require(token.balanceOf(address(this)) >= amountAllowed, "Foucet is empty!"); // 水龙头空了

        token.transfer(msg.sender, amountAllowed); // 转账，发送token
        requestAddress[msg.sender] = true; // 记录领取过代币的地址

        emit SendToken(msg.sender, amountAllowed); // 释放SendToken事件
    }

    function getAddress() public view returns (address) {
        return address(this); // 返回当前合约地址
    }

}