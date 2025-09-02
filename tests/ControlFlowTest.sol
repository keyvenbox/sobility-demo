// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ControlTest{

    function ifElseTest(uint _number) public pure returns (bool) {
        if (_number == 0) {
            return true;
        } else {
            return false;
        }
    } 

    function forTest() public pure returns (uint256){
        uint sum = 0;
        for (uint i = 0; i < 10; i++) {
            sum +=i;
        }        
        return sum;
    }

     function whileTest() public pure returns (uint256){
        uint sum = 0;
        uint i = 0;
        while (i < 10){
            sum += i;
            i++;
        }
        return sum;
    }

    function doWhileTest() public pure returns (uint256){
        uint sum = 0;
        uint i = 0;

        do {
            sum +=i;
            i++;
        } while (i < 11);

        return sum;
    }

    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        // return the max of x and y        
        return x >= y ? x : y;
    }

    // 插入排序 错误版 [2, 5, 3, 1]
    function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {   
        for (uint i = 1;i < a.length;i++){ 
            uint temp = a[i];  // 1 2 3
            uint j=i-1;        // 0 1 2
            while( (j >= 0) && (temp < a[j])){
                a[j+1] = a[j];
                j--;
            }
            a[j+1] = temp;
        }
        return(a);
    }

    // 插入排序 正确版 [2, 5, 3, 1]
    function insertSort(uint[] memory a) public pure returns (uint[] memory) { 
        for (uint i = 1; i < a.length; i++) {
            uint temp = a[i];  
            uint j = i;  
            while ( j > 0 && a[j - 1] > temp ) {
                a[j] = a[j-1];  
                j--;      
            }
            a[j] = temp; 
        }
        return a;
    }



}