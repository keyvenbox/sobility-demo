// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Solidity中的继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承

contract Yeye{

    event Log(string msg); // 定义事件

    // 定义3个function: hip(), pop(), yeye()，Log值为Yeye。
    function hip() public virtual {
        emit Log("Yeye");
    }

    function pop() public virtual {
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }

}

// 简单继承
contract Baba is Yeye {

    function hip() public virtual override {
        emit Log("Baba");
    }

    function pop() public virtual override {
        emit Log("Baba");
    }

    function baba() public virtual {
        emit Log("Baba");
    }

}

// 多重继承
contract Erzi is Yeye,Baba {

    function hip() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }

    function pop() public virtual override (Yeye, Baba) {
        emit Log("Erzi");
    }

    function erzi() public virtual {
         emit Log("Erzi");
    }

    //调用父合约的函数
    function callParent() public {
        // 直接调用
        Baba.pop();
        //Yeye.pop();

    }

    // super关键字调用
    function callParentSuper() public {
        //Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()：
        super.pop(); // 
    }
}


// 修饰器的继承
contract Base1 {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {

    // 重写修饰器
    modifier exactDividedBy2And3(uint _a) override {
        _;
        require(_a % 2 == 0 && _a % 3 == 0);
    }

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint _divedend) public exactDividedBy2And3(_divedend) pure returns (uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_divedend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns (uint, uint) {
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}

// 构造函数的继承
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}

// 在继承时声明父构造函数的参数
contract B is A(11) {
}

contract C is A {
    constructor(uint _c) A(_c * _c) {}
}


