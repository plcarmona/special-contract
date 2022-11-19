// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract FunctionOutputs{
    function returnMany() public pure returns(uint,bool){
        return(1,true);
    }
       function assingned() public pure returns(uint x,bool b){
        x=1;
        b=false;
    }
    function destructionAssiggments() public pure{
        (uint x, bool b) = returnMany();
        x;
        b;
    } 

}
contract Array{
    //dinamic o fixed 
    uint[] public  nums = [1,2,3];
    uint[3] public numsFixed = [4,5,6];
    //push get update delete pop length
    function examples() external {
        nums.push(4); //1,2,3,4
        uint x=nums[4];
        nums[2]=x;
        delete nums[1]; //[1,0,4,4]
        nums.pop();
        uint len=nums.length;
        //create array in memopry
        uint[] memory a = new uint[](5);
        a[1]=123;
    }
    function example()public{
        nums=[1,2,3];
        delete nums[1]; //1,0,3
        
    }
    function remove(uint _index) public {
        require(_index<nums.length,'index out of bounds');
        for (uint i=_index;i<nums.length-1;i++){
            nums[i]=nums[i+1];
        }
        nums.pop();
        }
    function test() external{
        nums =[1,2,3,4,5];
        remove(2);
        assert(nums[0]==1);
        assert(nums.length==4);
    }
}
contract ArrayReplacemeLast{
    uint[] public arr;
    function remove(uint _index) public{
        arr[_index]=arr[arr.length-1];
        arr.pop();
    }
    function test() external{
        arr=[1,2,3];
        remove(1);
        assert(arr.length==3);
    }
}
