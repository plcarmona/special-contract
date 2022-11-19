// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//3 ways to send eth
//transfer 2300gas, reverts
//send - 2300 gas , returns bool
//call -all, returns bool and data


contract CallContract{

    //forma 1
    function withdraw(EtherWallet _test, uint _x) external{
        _test.withdraw(_x);
    }
    //forma 2
    function getbal(address payable _test) external view returns(uint){
        return EtherWallet(_test).getBalance();
    }
}

contract EtherWallet{
    uint public x;
    address payable public owner;
    constructor(){
        owner =payable(msg.sender);
    }
    receive() external payable{}
    function withdraw(uint _amount) external{
        require(msg.sender== owner,"caller is not owner");
        payable(msg.sender).transfer(_amount);
    }
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}


contract SendEth{
    constructor()payable {}
    receive() external payable{}
    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(123);
    }
    function sendViaSend(address payable _to )external payable {
        bool sent=_to.send(123);
        require(sent,"send failed");
    }
    // this is the most used 
    function sendViaCall(address payable _to)external payable{
        (bool success,)=_to.call{value:123}("");
        require(success,"call failed");
    }
}

contract EthReciver{
    event Log(uint amount, uint gas);
    receive()external payable{
        emit Log(msg.value,gasleft());
    }
}

contract Payable{
    address payable public owner;
    constructor(){
        owner=payable(msg.sender);
    }
    function deposit() external payable{}

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
    fallback() external payable{} // this funct execute when we try to run a funt that doesnt exist
    receive() external payable{}
    }
