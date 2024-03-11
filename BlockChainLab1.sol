// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*Lab1: introduction to solidity:*/
contract test1{
    //Make function to take two inputs for two numbers from user and it returns int value too
    //put pure to fix any warning , pure means variables will not shown in any other place / or use view to any one see your data variables but they can't editon it
    function summation(int n1, int n2) pure public returns (int){ //In the brackets put the data type for the inpuut
            //Make function for addition for two numbers
            //Define variables
            int sum = n1+n2;
            return sum;

    }

    function subtracting(int n1,int n2) pure public returns(int){
        int sub = n1-n2;
        return sub;
    }

    function multiplication(int n1, int n2) pure public returns(int){
        int mult = n1*n2;
        return mult;
    }

    function division(int n1, int n2) pure public returns(int){
        int div = n1/n2;
        return div;
    }

    function greater(int n1, int n2) pure public returns(bool){
        if (n1>n2){
            return true;
        }
        else{
            return false;
        }
    }
}