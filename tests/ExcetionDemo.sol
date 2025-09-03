// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

error TransferNotOwner();

error TransferNotOwner2(address sender);


contract ErrorTest {

    mapping(uint256 => address) public _owners; // 定义_owner变量

    constructor(uint256 _tokenId, address _owner )  {
        _owners[_tokenId] = _owner;
    }

    // error
    function transferOwner(uint256 tokenId, address newOwner) public {
        if(_owners[tokenId] != msg.sender) {
            revert TransferNotOwner(); // 在执行当中，error必须搭配revert（回退）命令使用。
            //  revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    // require
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner"); // require命令不需要搭配revert命令
        _owners[tokenId] = newOwner;
    }

    // assert
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }


}

