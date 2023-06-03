// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// during construction, we have our "lot" created, but no house (runtime code) yet!
// this is so we can:
// 1) send money to the house (aka we have a mailbox associated with our lot, but no house yet)
// 2) access storage associated with that address (we can put furniture and packages on the lot, but still no house!)

contract PlaceHolderAddress {
    uint x = 1;

    constructor() payable {
        require(address(this).balance == 1 ether);
        require(msg.value == 1 ether);

        require(myself() == 4);
        require(x == 1);
    }

    function myself() internal pure returns (uint) {
        return 4;
    }
}

