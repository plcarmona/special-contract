// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract FuntionModifier{
bool public paused;
uint public count;
	function setPause(bool _paused) external{
		paused=_paused;
	}
	modifier whenNotPaused(){
	require(!paused,'paused');
	_;
	}
	function inc()external whenNotPaused{
		require(!paused,'paused');
		count+=1;
	}
	function dec()external whenNotPaused{
		require(!paused,'paused');
		count-=1;
	}
}
contract Constructor{
    address public owner;
    uint public x;
    constructor(uint _x){
        owner = msg.sender;
        x= _x;
    }
}
