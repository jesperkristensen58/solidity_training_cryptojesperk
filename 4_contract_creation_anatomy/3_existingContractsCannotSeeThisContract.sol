// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "hardhat/console.sol";

contract DuringConstruction {

    constructor(ExistingContract someExistingContract) payable {
	// Here we conduct various experiments to confirm that value can be transferred
	// between "houses" (contract runtime codes) during construction, but other houses
	// can't call into our own house (b/c we don't have one yet!)
	
        // 1: CAN I CALL MY OWN INTERNAL/PUBLIC FUNCTIONS? CALL MY OWN PUBLIC FUNCTION ("INTERNAL" IN BEHAVIOR)
        require(someFunction() == 4); // I can call my own internal, public, and private functions

        // 2: CAN OTHER CONTRACTS CALL MY FUNCTIONS? MAKE ANOTHER EXISTING CONTRACT CALL MY FUNCTION DURING CONSTRUCTION
        // require(someExistingContract.someFunction(this) == 4);

        // 3: CAN I CALL MY OWN EXTERNAL FUNCTIONS? CALL MY OWN FUNCTION, BUT AS AN EXTERNAL FUNCTION:
        // SO IT'S LIKE IM SEEING MYSELF FROM THE PERSPECTIVE OF OUTSIDE MYSELF
        // require(this.someExternalFunction() == 6);

        // 4: MAKE THE EXISTING CONTRACT SEND ETHER TO US - DOES IT TRIGGER THE FALLBACK?:
        someExistingContract.sendFundsToAContractDuringItsConstruction{value: 1 ether}(this);
    }

    function someFunction() public pure returns (uint) {
        return 4;
    }

    function someExternalFunction() external pure returns (uint) {
        return 6;
    }

    fallback() external payable {
        console.log("FALLBACK!");
        // revert();
    }
}


// ------ SOME EXISTING CONTRACT ON THE BLOCKCHAIN (SITTING IN THE WORLD STATE)
contract ExistingContract {
    function someFunction(DuringConstruction _contract) external pure returns (uint) {
        return _contract.someFunction();
    }

    function sendFundsToAContractDuringItsConstruction(DuringConstruction _contract) payable external {
        console.log("SENDING FUNDS!");
        require(msg.value == 1 ether);
        (bool ok, ) = payable(_contract).call{value: 1 ether}("");
        require(ok);
    }
}
