pragma solidity ^0.4.16;

import "./Token.sol"; //Your Token Contract Code

contract AirDrop {

  Token token;
  address public owner;
  event TransferredToken(address indexed to, uint256 value);
  event FailedTransfer(address indexed to, uint256 value);


  function AirDrop () {
      owner = msg.sender;
      address _tokenAddr = 0xTOKENADDRESS; //here pass address of your token
      token = Token(_tokenAddr);
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) onlyOwner {
    require(newOwner != address(0));
    owner = newOwner;
  }
  
  // this function can be used when you want to send same number of tokens to all the recipients
  function sendTokensSingleValue(address[] dests, uint256 value) onlyOwner external {
    uint256 i = 0;
    uint256 toSend = value *10^18; // Change 10^18  - change the 18 to whatever decimal that your ERC20 Token uses
    while (i < dests.length) {
        sendInternally(dests[i] , toSend, value);
        i++;
    }
  }  

  function sendInternally(address recipient, uint256 tokensToSend, uint256 valueToPresent) internal {
    if(recipient == address(0)) return;

    if(tokensAvailable() >= tokensToSend) {
      token.transfer(recipient, tokensToSend);
      TransferredToken(recipient, valueToPresent);
    } else {
      FailedTransfer(recipient, valueToPresent); 
    }
  }   
 
  function tokensAvailable() constant returns (uint256) {
    return token.balanceOf(this);
  }

  function destroy() onlyOwner payable {
    uint256 balance = tokensAvailable();
    require (balance > 0);
    token.transfer(owner, balance);
    selfdestruct(owner);
  }
}