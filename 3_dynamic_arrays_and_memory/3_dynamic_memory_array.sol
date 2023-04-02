pragma solidity 0.8.18;

contract DynamicArrayMemory {
    // uint[] a;

    function dynamicMemoryArr() public {
        uint[] memory a;

        a.push(2); // dynamic array not available in memory
    }
}
