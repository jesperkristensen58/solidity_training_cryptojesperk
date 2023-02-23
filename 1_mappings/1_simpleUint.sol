// SPDX-License-Identifier: MIT
// @author Jesper Kristensen (@cryptojesperk)
pragma solidity 0.8.7;

contract StorageLayout {
    uint256 x;
    uint128 y;
    uint128 z;

    function set(uint newX, uint128 newY, uint128 newZ) public {
        x = newX;
        y = newY;
        z = newZ;
    }

    // HELPER TO READ FROM STORAGE SLOTS
    function readStorageSlot(uint256 i) public view returns (bytes32 content) {
        assembly {
            content := sload(i)
        }
    }
}
