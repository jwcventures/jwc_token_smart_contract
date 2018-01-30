pragma solidity ^0.4.18;

import './ERC20BasicToken.sol';
import './Ownable.sol';
import './SafeMath.sol';
import './Pausable.sol';

contract JWCToken is ERC20BasicToken {
	using SafeMath for uint256;

	string public constant name      = "JWC"; //tokens name
	string public constant symbol    = "JWC"; //token symbol
	uint256 public constant decimals = 18;    //token decimal
	string public constant version   = "1.0"; //tokens version

	uint256 public constant tokenPreSale         = 100000000 * 10**decimals;//tokens for pre-sale
	uint256 public constant tokenPublicSale      = 400000000 * 10**decimals;//tokens for public-sale
	uint256 public constant tokenReserve         = 300000000 * 10**decimals;//tokens for reserve
	uint256 public constant tokenTeamSupporter   = 120000000 * 10**decimals;//tokens for Team & Supporter
	uint256 public constant tokenAdvisorPartners = 80000000  * 10**decimals;//tokens for Advisor

	address public icoContract;

	// constructor
	function JWCToken() public {
		totalSupply = tokenPreSale + tokenPublicSale + tokenReserve + tokenTeamSupporter + tokenAdvisorPartners;
	}

	/**
	 * Set ICO Contract for this token to make sure called by our ICO contract
	 * @param _icoContract - ICO Contract address
	 */
	function setIcoContract(address _icoContract) public onlyOwner {
		if (_icoContract != address(0)) {
			icoContract = _icoContract;
		}
	}

	/**
	 * Sell tokens when ICO. Only called by ICO Contract
	 * @param _recipient - address send ETH to buy tokens
	 * @param _value - amount of ETHs
	 */
	function sell(address _recipient, uint256 _value) public whenNotPaused returns (bool success) {
		assert(_value > 0);
		require(msg.sender == icoContract);

		balances[_recipient] = balances[_recipient].add(_value);

		Transfer(0x0, _recipient, _value);
		return true;
	}

	/**
	 * Pay bonus & affiliate to address
	 * @param _recipient - address to receive bonus & affiliate
	 * @param _value - value bonus & affiliate to give
	 */
	function payBonusAffiliate(address _recipient, uint256 _value) public returns (bool success) {
		assert(_value > 0);
		require(msg.sender == icoContract);

		balances[_recipient] = balances[_recipient].add(_value);
		totalSupply = totalSupply.add(_value);

		Transfer(0x0, _recipient, _value);
		return true;
	}
}
