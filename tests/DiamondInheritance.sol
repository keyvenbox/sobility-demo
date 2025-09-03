// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {

    event Log(string msg);

    function foo() public virtual  {
        emit Log("God.foo called");
    }
    
    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {

    function foo() public virtual override { // 重写foo
        emit Log("Adam.foo called");
        super.foo(); // 调用父合约的foo
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {

    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }

}

contract People is Adam, Eve {

    function foo() public override(Adam, Eve) { // 重写foo
        emit Log("People.foo called");
        super.foo(); // 调用父合约的foo
    }

    function bar() public override (Adam, Eve) {
         emit Log("People.bar called");
        super.foo(); // 调用父合约的foo
    }
}



