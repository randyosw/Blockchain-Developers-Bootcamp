// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CharitySmartContract {

//create a charity smart contract OK
//assign owner and charity address in the contructor to state variables
//create receive function so the contract can receive balance
//create tip function to send balance to owner
//create donate function to send all the balance in the contract to charity

    address internal owner;
    address public charity;
    receive() external payable { }
    constructor (address _charity) {
        owner = msg.sender;
        charity = _charity;
    }
    modifier onlyOwner() {
        require(owner == msg.sender, "InsufficientBalance");
        _;
    }

    function tipETH () external payable returns (bool) {
        (bool sent, ) = owner.call{value: msg.value}("");
        return sent;
    }

    function donateETH (address payable _charity, uint _amount) external onlyOwner {
        require(address(this).balance >= _amount, "InsufficientBalance");
        _charity.transfer(_amount);
    }
}