// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract GTXToken {


  string public  constant name = "GTXToken" ; 
  string public constant symbol = "GTX";
  uint public constant decimals = 18;
  

  mapping (address => uint256) Balance ;
  mapping (address=> mapping (address=> uint256)) Allowance ;
  uint256 Total_Supply ; 

   event TransferFund(address indexed  from, address indexed to , uint amount);
   event Approval(address indexed  transferOwner, address indexed approvedReceiver , uint amount);

  constructor() {
         
         Total_Supply = 1000000;
         Balance[msg.sender] = Total_Supply ;

  }


  function getSupply() public  view returns (uint256) {
    return Total_Supply ;
  }

  function getBalanceOf (address user) public  view  returns (uint256) {
    return Balance[user];
  }

 
 
  function transfer (address receiver , uint256 amount ) public  returns (bool) {
    require(amount <= Balance[msg.sender]);
    Balance[msg.sender] = Balance[msg.sender] - amount ;
    Balance[receiver] = Balance[receiver] + amount ;

    emit TransferFund(msg.sender,receiver , amount);
    return true ;

  } 

  function approve (address ApprovedReceiver , uint amount) public returns (bool){
    Allowance[msg.sender][ApprovedReceiver] = amount ;
     emit Approval(msg.sender, ApprovedReceiver, amount);

     return true ;
     
  }

  function getAllowance (address Owner , address Receiver ) public  view returns (uint) {
    return Allowance[Owner][Receiver];
  }

  function transferFrom (address owner , address receiver , uint amount ) public returns(bool) {
              require(amount <= Balance[owner]);
              require(amount <= Allowance[owner][msg.sender]);

            Balance[owner] = Balance[owner] - amount ;
            Balance[receiver] =  Balance[receiver] + amount ;
            Allowance[owner][msg.sender] =  Allowance[owner][msg.sender] - amount ;
            emit TransferFund(owner,receiver , amount);
            return true;

  }



}