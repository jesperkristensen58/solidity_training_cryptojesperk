pragma solidity 0.8.18;

contract DynamicArrayStorage {
    uint x = 2;
    uint[] a;

    function pushToArray(uint value) public {
        a.push(value);
    }

    function getStorageBucket(uint index) public view returns (uint content) {
        assembly {
            content := sload(index)
        }
    }

    function getHashOfBucket(uint index) public pure returns (uint hashVal) {
        return uint(keccak256(abi.encode(index)));
    }
}
