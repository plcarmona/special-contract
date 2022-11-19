// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//mappping
//how to declare a mapping
//set get delete


contract Mapping{
    mapping(address => uint)public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    function examples()external{
        balances[msg.sender]=123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)];
        balances[msg.sender]+=456;
        delete balances[msg.sender];
        isFriend[msg.sender][address(this)]=true;
    }
}
contract IterableMapping{
    mapping(address => uint)public balances;
    mapping(address => bool)public inserted;
    address[] public keys;
    function set(address _key, uint _val) external{
        balances[_key]=_val;
        if (!inserted[_key]){
            inserted[_key]=true;
            keys.push(_key);
        }
    }
    function getSize()external view returns(uint){
        return keys.length;
    }
    function first()external view returns(uint){
        return balances[keys[0]];
    }
    function get(uint _i)external view returns(uint){
        return balances[keys[_i]];
    }
}
contract Structs{
    struct Car {
        string model;
        uint year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address=>Car[])public carsByOwner;

    function examples() external{
        Car memory toyota=Car("Toyota",1990,msg.sender);
        Car memory lambo=Car({model:"Lamborghini",year:1980,owner:msg.sender});
        Car memory tesla;
        tesla.model="Tesla";
        tesla.year=2020;
        tesla.owner=msg.sender;
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        cars.push(Car("Ferrari",2020,msg.sender));
        // Car memory _car=cars[0];
        Car storage _car=cars[0];
        _car.model="susuki";
        delete _car.owner;
        delete cars[1];
    }
}
contract Enum{
    enum Status{
        None,
        Pending,
        Completed,
        Shipped,
        Rejected,
        Canceled
    }
    Status public status;
    struct Order {
        address buyer;
        Status status;
    }
    Order[]public orders;
    function get() public view returns (Status) { 
        return status;
    }
    function set(Status _status) external{
        status =_status;

    }
    function ship()external{
        status=Status.Shipped;
    }
}
//hayu que retomar mas adelante.
contract Proxy{
    event Deploy(address);
    fallback() external payable{}
    function deploy(bytes memory _code)external payable returns (address addr){
        assembly{
            //create(v,p,n)
            //v amount of eth to send
            //p= pointer in memory to start of code
            //n sizze of the code
            addr:=create(callvalue(), add(_code,0x20),mload(_code))
        }
        require(addr != address(0),"deploy failed");
        emit Deploy(addr);
    }
    function excetute(address _target, bytes memory _data) external payable{
        (bool success,)= _target.call{value:msg.value}(_data);
        require(success,"failed");
    }
    function getBytecode1() external pure returns(bytes memory){
        bytes memory bytecode=type(Enum).creationCode;
        return bytecode;
    }
    function getBytecode2(uint _x,uint _y) external pure returns(bytes memory){
        bytes memory bytecode=type(Structs).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_x,_y));
    }
    function getCalldata(address _owner) external pure returns(bytes memory){
        return abi.encodeWithSignature("setOwner(adress)", _owner);
    }
}