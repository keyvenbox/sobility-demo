// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract {

    uint256 private _x = 0; // 状态变量_x
    event Log(uint amount, uint gas); // 收到eth的事件，记录amount和gas

    // 返回合约ETH余额
    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
    
    // 读取_x
    function getX() external view returns(uint256) {
        return _x;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
         _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

}

// 调用OtherContract合约
contract CallContractTest {

    // 合约构造函数，payable修饰符表示可以转入ETH
    constructor(uint256 initailSupply) payable {
        require(initailSupply > 0, "");
    } 


    //4个调用合约的例子
    //1.传入合约地址
    function callSetX(address _address ,uint256 x) external payable {
        OtherContract(_address).setX(x); // 直接调用setX函数
    }

    // 2.传入合约变量
    function callGetX(OtherContract _Address) external view returns(uint256) {
        return _Address.getX();
    }

    //3.创建合约变量
    function callGetX2(address _Address) external view returns(uint256) {
        OtherContract other = OtherContract(_Address);
        return other.getX();
    }

    // 4.调用合约并发送ETH
    function setXTransferETH(address otherContract, uint256 x) external payable {
        OtherContract(otherContract).setX{value: msg.value}(x);
    }

}