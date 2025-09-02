// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloWeb3 {
    string public _string = "hello web3!";
}

//1. 布尔型
contract Boolean {

    bool public _bool = true;
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 =  _bool == _bool1; // 等于
    bool public _bool5 = _bool != _bool1; // 不相等
}

// 2. 整型
contract Intnumber {
    int public _int = -1;  // 整数，包括负数
    uint public _unit = 1; // 无符号整数
    uint256 public _number = 20220330; // 256位无符号整数

    uint256 public _number1 = _number + 1;
    uint256 public _number2 = 2**2;// 指数
    uint256 public _number3 = 7 % 2; // 取余
    bool public _numberbool = _number2 > _number3; // 比大小
}

//3. 地址类型
contract Address {
    // 地址
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    // 可以转账 查余额
    address payable public _address1 = payable(_address);
    // 余额
    uint256 public balance = _address1.balance;
}

// 4. 定长字节数组

contract Bytes {

    bytes32 public _bytes32 = "MiniSolidity";
    bytes1 public _bytes1 = _bytes32[0];
}

// 5. 枚举 enum
contract Enum {
    enum ActionSet {Buy, Hold, Sell}

    ActionSet action = ActionSet.Buy;
    function enumToUnit() external view returns(uint) {
        return uint(action);
    }
   
    
}