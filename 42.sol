// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


//Call
contract Call  {
    bytes public data;
    function callFoo(address _test)external{
        (bool success, bytes memory b)=_test.call(abi.encodeWithSignature("foo(string,uint256)", "call foo",123));
        require(success,"call failed");
        data=b;
    }
}





// interface permite llamar a otro contrasto cuando no se tiene acceso a este.
//cuando se inicia se pasa la direccion del contrato al cual no se tiene acceso y luego se puede llamar desde ICounter
interface ICounter{
    function count()external view returns(uint);
    function inc() external;
}
contract CallInterface {
    uint public count;
    function examples(address _counter) external{
        ICounter(_counter).inc();
        count=ICounter(_counter).count();
    }
}