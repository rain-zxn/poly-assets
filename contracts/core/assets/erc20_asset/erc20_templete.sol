pragma solidity ^0.5.0;


import "./../../../libs/GSN/Context.sol";
import "./../../../libs/token/ERC20/ERC20.sol";
import "./../../../libs/token/ERC20/ERC20Detailed.sol";
import "./../../../libs/ownership/Ownable.sol";

contract ERC20Template is Context, ERC20, ERC20Detailed, Ownable {
    mapping(address => bool) private _blacklist;

    event BlacklistAdded(address indexed account);
    event BlacklistRemoved(address indexed account);

    constructor () public ERC20Detailed("Poly-peg-test", "POT", 18) {
        _mint(_msgSender(), 1000000000000000000000);
    }

    function addToBlacklist(address account) external onlyOwner {
        require(account != address(0), "Invalid account address");
        require(!isBlacklisted(account), "Account is already blacklisted");

        _blacklist[account] = true;
        emit BlacklistAdded(account);
    }

    function removeFromBlacklist(address account) external onlyOwner {
        require(account != address(0), "Invalid account address");
        require(isBlacklisted(account), "Account is not blacklisted");

        _blacklist[account] = false;
        emit BlacklistRemoved(account);
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(!isBlacklisted(msg.sender), "Your account is already blacklisted");
        require(!isBlacklisted(recipient), "Recipient's account is already blacklisted");

        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(!isBlacklisted(sender), "Sender's account is already blacklisted");
        require(!isBlacklisted(recipient), "Recipient's account is already blacklisted");

        return super.transferFrom(sender, recipient, amount);
    }

    function isBlacklisted(address account) public view returns (bool) {
        return _blacklist[account];
    }
}