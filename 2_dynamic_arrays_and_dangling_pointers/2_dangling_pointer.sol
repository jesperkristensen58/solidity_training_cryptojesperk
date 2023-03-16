// @author Jesper Kristensen, @cryptojesperk
// @year 2023
pragma solidity 0.8.17;

contract Storage {
    uint[][] s;

    function add() public {
        s.push();
        s[0].push(4);
        s[0].push();
        s[0].push(6);
    }

    function pop() public {
        s.pop();
    }

    function f() public {
        uint[] storage ptr = s[s.length - 1];
        
        s.pop();

        ptr.push(0x42);
        
        s.push();
        assert(s[s.length - 1][0] == 0x42);
    }

    // HELPER TO READ FROM STORAGE SLOTS
    function readStorageSlot(uint256 i) public view returns (bytes32 content) {
        assembly {
            content := sload(i)
        }
    }

    function getLocationOfDynamicArray(uint dynamicArraySlot) public pure returns (uint) {
        // dynamicArraySlot: the slot that the dynamic array itself sits in
        return uint256(keccak256(abi.encode(dynamicArraySlot)));
    }
}
