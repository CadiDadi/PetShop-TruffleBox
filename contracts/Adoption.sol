//tells compiler what versions are valid: >= 0.4.17 to > 0.5 (as changes are made to the compiler, it compiles solidity code into bytecode differently)
pragma solidity ^0.4.24;
//contract names always start with capital letter
contract Adoption {
    /*
    -declare a state variable at top of contract:
    -type declaration (fixed length array) address keyword followed by length
    -define the variable Public (getter function automatically created for State Variables defined Public)
    -because it is an array, the getter function will require the index of the value we would like returned as input.
    */
    address[16] public adopters;
    //function updates the adopters state variable reflecting state change
    //one paramenter: petId of type: uint
    function adopt(uint petId)
        //public - any external address can call it
        public
        //return uint to indicate successful execution of function
        returns(uint)
    {
        //require() checks if user sent valid input: petId of 0-15. if not, the function throws an exception and stops execution
        require(petId >= 0 && petId <=15);
        //the value of the adopters array at index of value petId is set to msg.sender (the address that called the function) 
        adopters[petId] = msg.sender;
        //returns petId the user supplied
        return petId;
    }
    //getter function (auto-created because public) to read all of the values of the adopters array w/ one function call
    function getAdopters()
        public
        //does not modify state of the contract, just reads & returns a value (no state change = no gas & free to call)
        view
        //requires index of address we want returned, only returns 1 value
        returns(address[16])
    {
        return adopters;
    }
}