// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*Lab3 task details in the below link:*/
/*https://app.cadena.dev/ZHjzLozd3mCsAcgMfeHE/lesson/ethereum-101/lesson-eth-5/5*/

contract Bank{

    //Declare state variable at contract level

    /*variable to store the ethereum address of bank contract owner.
    As it is public: solidity generated a getter function to allow 
    other contracts to read the value of bank owner.
    The bankOwner address is checked against msg.sender (caller address) to ensure that only owner can call these functions.*/
    address public bankowner; 

    /*variable to store the bank name. it is public. The setBankName function 
    enables the owner to update the bank name if needed!*/
    string public bankName;

    /*it stores the balance of bank customer. customerBalance to know how much
    ether each sustomer has deposited in the bank.
    It uses depositMoney and withdrawMoney to update customer balances!*/
    mapping(address => uint256) public customerBalance;

    /*constructor declaration func. used to initialize contract stte variable.
    it executes once and auto when contract is deployes*/
    constructor(){
        /*initializing the bankowner state to 
        deploy the contract msg.sender which represents the address of the account*/
        bankowner = msg.sender;
    }

    /*way to our costomer to deposit money to our bank. It's public to 
    allow it to be callend internally or externally. Payable to receive money in our contract*/
    function depositMoney() public payable {
        if(msg.value==0){revert("You need to deposit some amount of money!");}
        else{ customerBalance[msg.sender] += msg.value; }
    }

    function setBankName(string memory _name) external {
            if(msg.sender != bankowner){revert("You must be the owner to set the name of the bank..");}
            else{ bankName = _name; }
    }
        
    function withdrawMoney(address payable _to, uint256 _total) public payable{
            if (_total > customerBalance[msg.sender]) {
                revert("You have insufficient funds to withdraw");
            }
            else { 
                customerBalance[msg.sender] -= _total;
               _to.transfer(_total); //??????
            }
    }

    //create getter to get the balance of the wallet calling our contract.
    function getCustomerBalance() external view returns (uint256){
           return customerBalance[msg.sender];

    }

    function getBankBalance() public view returns(uint256){
        if(msg.sender == bankowner){
            return address(this).balance;
        }
        else{
            revert("You must be the owner of the bank to see all balance!");
        }
    }

}


