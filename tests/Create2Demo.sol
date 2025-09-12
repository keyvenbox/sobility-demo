// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 用create2方法实现一个极简版的Uniswap：Pair币对合约负责管理币对地址，PairFactory工厂合约用于创建新的币对，并管理币对地址。
// WBNB地址: 0x2c44b726ADF1963cA47Af88B284C06f30380fC78
// BSC链上的PEOPLE地址: 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c

// calculateAddr计算出的合约地址： 0x17360f05dB35317FD0b477B4AE14bA3fd1841F0C

contract Pair {

    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, "UniswapV2: FORBIDDEN"); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }

}

contract PairFactory2 {

    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {

        require(tokenA != tokenB, "IDENTICAL_ADDRESS"); // 避免tokenA和tokenB相同产生的冲突
        // 用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) :  (tokenB, tokenA); // 按大小排序
        bytes32 salt =  keccak256(abi.encodePacked(token0, token1));
        Pair pair = new Pair{salt: salt}(); // 创建Pair合约
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 保存新Pair地址到getPair和allPairs
        pairAddr = address(pair);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
        allPairs.push(pairAddr);
    }

    // 提前计算pair合约地址
    function calculateAddr(address tokenA, address tokenB) external returns(address predictedAddress) {

        require(tokenA != tokenB, "IDENTICAL_ADDRESS"); // 避免tokenA和tokenB相同产生的冲突
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 计算合约地址方法 hash()
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff), 
            address(this),
            salt,
            keccak256(type(Pair).creationCode)
            )))));
        // 如果部署合约构造函数中存在参数
        // predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        //         bytes1(0xff),
        //         address(this),
        //         salt,
        //         keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
        //     )))));
    }

}