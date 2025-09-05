// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


/**
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
*/

event Received(address Sender, uint Value);
event FallbackCalled(address Sender, uint Value, bytes Data);

contract FallbackTest {

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable { 
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }

}