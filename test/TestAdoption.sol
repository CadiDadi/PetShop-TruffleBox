
pragma solidity ^0.4.24;

import "truffle/Assert.sol"; //Assert.sol library – provided by Truffle (you can provide your own library)
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol"; //contract being tested

//Test contracts MUST start with “Test”, ex. TestAdoption.sol
contract TestAdoption {
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // Testing the adopt() function
    //We call the adopt function and save the return value
    //We check that the return value is what is expected with the Assert.equal function & include a message that corresponds to the functionality we are testing
    //Function tests MUST start with “test”
    function testUserCanAdoptPet() public {
      uint returnedId = adoption.adopt(8);
      uint expected = 8;
      Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded.");
    }

    // Testing retrieval of a single pet's owner
    //check that the getter function created for the Adopters variable returns the correct address (in function testUserCanAdoptPet() pet #8 was adopted)    
    function testGetAdopterAddressByPetId() public {
      // Expected owner is this contract (this)
      address expected = this;
      //save the 8th adopter by calling adoption.adopters(8)
      address adopter = adoption.adopters(8);
      //check that the return value is what is expected with the Assert.equal function & provide appropriate message for the test
      Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
    }

    // Testing retrieval of all pet owners    
    function testGetAdopterAddressByPetIdInArray() public {
      // Expected owner is this contract
      address expected = this;
      //should return entire array of adopter addresses
      // Store adopters in MEMORY rather than contract's STORAGE (we only need the array temporarily to check in the Assert statement(does not need to persist))
      address[16] memory adopters = adoption.getAdopters();
      //once have array, we save the 8th index to check
      Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
    }
}