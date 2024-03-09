pragma solidity ^0.5.0;

/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.
*/

// Define a new contract named `JointSavings`
contract JointSavings {
    // Variables declaration
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;


    // Set accounts with access to the joint savings
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    // Deposit funds to the contract
    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    // Withdraw funds from the contract
    function withdraw(uint amount, address payable recipient) public {
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!");

        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    // Default fallback function to receive Ether
    function() external payable {
        deposit();
    }
}
