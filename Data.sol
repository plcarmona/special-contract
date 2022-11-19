// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Data location storage, memory and calldata
// storage for state variables, memory is loaded on memory and calldata is like memory but for funtion inputs  [save gas, evitando copias]
///inheritance, permite aprovechar cuando existe harto codigo duplicado.
// parent functions direct and super. direct especifical cual llamar, super llama a todas las funciones padres*


contract E{
    event Log(string meddage);
    function foo()public virtual{
    emit Log("E.foo");
    }
    function bar()public virtual{
    emit Log("E.bar");
    }
}
contract F is E{
    function foo()public virtual override{
    emit Log("F.foo");
    E.foo();
    }
    function bar()public virtual override{
    emit Log("F.bar");
    super.bar();
    }
}
contract G is E{
    function foo()public virtual override{
    emit Log("G.foo");
    }
    function bar()public virtual override{
    emit Log("G.bar");
    }
}
contract H is F,G{
    function foo()public virtual override(F,G){
    F.foo();
    }
    function bar()public virtual override(F,G){
    super.bar();
    }
}

contract S{
    string public name;
    constructor (string memory _name){
        name=_name;
    }
}
contract T{
    string public text;
    constructor (string memory _text){
        text=_text;
    }
}
contract U is S("s"), T("t"){
}
contract V is S,T{
    constructor(string memory _name,string memory_text)S(_name) T(_text){

    }
}

contract U is S("s"){
    constructor(string memory _name,string memory_text)T(_text){

    }
}
//multiple inheritance
/*
    x
   /\
  y |
  \ |
   Z
*/
contract Z is A,B{
    function foo() public pure override(A,B) returns(string memory){
        return "Z";
    }
}
//inheritance
contract A{
    function foo() public pure virtual returns (string memory){
        return "A";
    }
    function bar() public pure returns (string memory){
        return "A";
    }
}
contract B is A{
    function foo() public pure override returns(string memory){
        return "B";
    }
}

contract Event{
    event Log(string message, uint val);
    //upto 3 index
    event IndexedLog(address indexed sender, uint val);
    function example() external {
        emit Log("foo",1234);
        emit IndexLog(msg.sender,789);
    }
    event Message(address indexed _from, address indexed _to, string message);
    funtion sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender,_to,message);
    }
}
contract TodoList{
    struct TodoList{
        string text;
        bool completed;   
    }
    Todo[] public todos;
    
    function create(string calldata _text) external{
        todos.push(Todo({
            text: _text,
            completed:false
        }));
    }
    function updateText(uint _index, string calldata _text) external{
        //forma 1
        todo[_index].text=_text;
        //forma 2, mas barato en gas cuando se requiere actualizar varios campos ----4 o mas?
        Todo storage todo= todos[-index];
        todo.text=_text;
    }
    function toggleCompleted(uint _index) external{
        todos[_index].completed= !todos[_index].completed;
    }

    function get(uint _index) external view returns(string memory, bool){
        Todo memory todo = todos[_index];
        return (todos.text,todo.completed);

    }

}
contract SimpleStorage{
    string public text;
    function setText(string calldata _text) external{
        text=_text;
    } 
    function get() external view returns(string memory) {
        return text;
    }
}
contract Dataloc{
    struct MyStruct{
        uint foo;
        string text;
    }
    mapping(address=>MyStruct)public myStructs;
    funtion examples(uint[] calldata y,string memory s) external returns(uint[] memory){
        myStructs[msg.sender]=myStruct({foo:123,text:"bar"});
        MyStruct storage myStruct=myStruct[msg.sender];
        myStruct.text="foo";

        MyStruct memory myStruct=myStruct[msg.sender];
        readOnly.foo=456;
        
        _internal(y);

        uint[]memory memArr=new uint[](3);
        memArr[0]=234;
        return memArr;

    }
    function _internal(uint[] calldata y) private{
        uint x=y[0]
    }
}