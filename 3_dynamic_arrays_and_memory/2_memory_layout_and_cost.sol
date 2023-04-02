pragma solidity 0.8.18;

contract MemoryLayout {

    function probeMemoryLayout(uint length, uint memIndex) public view returns (bytes32 content) {
        uint[] memory a = new uint[](length);

        a[0] = 10;
        a[a.length - 1] = 4;

        assembly {
            content := mload(mul(memIndex, 0x20))
        }
    }

    function memoryCrash() public view returns (uint content) {
        assembly {
            content := mload(mul(130000, 0x20))
        }
    }
}
