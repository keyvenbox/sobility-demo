// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract OtherContract {

    uint256 private _x = 0; // 状态变量x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);

    event fallbackCalled(address sender, uint value, bytes data );
    // 定义事件
    event Received(address Sender, uint Value);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    } 

    fallback() external payable {
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }   

    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
        _x = x;
        // 如果转入ETH，则释放Log事件
        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns(uint256 x) {
        x = _x;
    }

}


contract CallContract {

    event Resposne(bool success, bytes data);

    function callSetX(address payable _address, uint256 x) external payable {
        // call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _address.call{value: msg.value}(abi.encodeWithSignature("setX(uint256)", x));

        emit Resposne(success, data);
    }

    function callGetX(address _address) external returns(uint256 x){
        // call getX
        (bool success, bytes memory data) =  _address.call(abi.encodeWithSignature("getX()"));
        emit Resposne(success, data);
        return abi.decode(data, (uint256));
    }

    function callNonExist(address _address) external {
        (bool success, bytes memory data)  = _address.call(abi.encodeWithSignature("foo()"));
        emit Resposne(success, data);
    }
}
