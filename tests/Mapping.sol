// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// 我们定义一个结构体 Struct
struct Student{
    uint256 id;
    uint256 score; 
}

contract MappingTest{

    mapping(uint => address) public idToAddress; // id映射到地址
    mapping(address => uint) public addressToId; // 地址映射到id

    //mapping(Student => uint) public studentToId; // Struct映射到id, 映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体
    mapping(uint => Student) public idToStudent; // id映射到Struct

    // 新增键值对
    function writeMap(uint _key, address _value ) public {
        idToAddress[_key] = _value;
    }

    // 读取键值对
    function readMap(uint _key) public view returns(address) {
        return idToAddress[_key];
    }
    
    Student public student;


    // delete操作符
    bool public _bool2 = true; 
    function del() external {
        delete _bool2; // delete 会让_bool2变为默认值，false
    }

}