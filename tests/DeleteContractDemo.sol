// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Demo-转移ETH功能
// 当我们调用deleteContract()函数，合约将触发selfdestruct操作。在坎昆升级前，合约会被自毁。但是在升级后，合约依然存在，只是将合约包含的ETH转移到指定地址，而合约依然能够调用。
contract DeleteContract {

    uint public value = 10;

    constructor() payable {}

    receive() external payable {}

    function deleteContract() external {
        // 调用selfdestruct销毁合约，并把剩余ETH转给msg.sender
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint256 balance) {
        balance = address(this).balance;
    }

}


// Demo-同笔交易内实现合约创建-自毁
// 根据提案，原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以我们需要通过另一个合约进行控制。
contract DeployContract {

    struct DemoResult{
        address addr;
        uint balance;
        uint value;
    }

    constructor() payable {}

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function demo() public payable returns(DemoResult memory) {

        DeleteContract del = new DeleteContract{value: msg.value}();

        DemoResult memory result = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });

        
        return result;
    }

    function deleteContract(DeleteContract del) public {
        del.deleteContract();
    } 

}