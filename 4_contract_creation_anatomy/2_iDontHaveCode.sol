// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "hardhat/console.sol";

contract DuringConstruction {
    constructor(ExistingContract someExistingContract) {
	// I ask another house on the lot: "Hey, do I have a house on my own lot yet?"
        uint size = someExistingContract.checkIfIHaveCode(this);
	// if the size == 0: this means they are replying "No, you don't!"

        console.log("My code size = ", size);
    }
}


// ------ SOME EXISTING CONTRACT ON THE BLOCKCHAIN (SITTING IN THE WORLD STATE)
contract ExistingContract {
    function checkIfIHaveCode(DuringConstruction _contract) external view returns (uint) {

        // get the size of the code of the _contract:
        uint size;
        assembly {
            size := extcodesize(_contract)
        }
        console.log("The size of the code at address 'address(_contract)' is = ", size);
        return size;
    }
}
