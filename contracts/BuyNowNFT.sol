// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/**
 * @dev This implements an NFT contract that supports picking which NFT to purchase. 
 */
contract BuyNowNFT is ERC721, AccessControl {
    using Strings for uint256;

    event Purchase(uint256 tokenId);
    event Airdrop(uint256 tokenId);
    event NewURI(string oldURI, string newURI);

    uint256 public price = 0.001 ether;
    string public baseUri = "https://bafybeih7luovrzwkle2ua6yoplzj7cd4yu5glwktjwa3qqisnraorm7l74.ipfs.nftstorage.link/";

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant AIRDROPPER_ROLE = keccak256("AIRDROPPER_ROLE");

    constructor() payable ERC721("Example Airdropper", "ARDRP") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(AIRDROPPER_ROLE, msg.sender);
    }
        
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // MODIFIERS

    modifier isCorrectPayment(uint256 _quantity) {
        require(msg.value == (price * _quantity), "Incorrect Payment Sent");
        _;
    }

    modifier isAvailable(uint256 _tokenId) {
        require(0 < _tokenId && _tokenId < 101, "Token ID out of range of available tokens.");
        require(!_exists(_tokenId), "Token not available");
        _;
    }

    // PUBLIC

    function purchase(address _recipient, uint256 _tokenId) 
        external  
        payable
        isCorrectPayment(1)
        isAvailable(_tokenId) 
    {
        purchaseInternal(_recipient, _tokenId);
    }

    /**
     * @dev Permits AIRDROPPER_ROLE to send specific _tokenId to specific _recipient without paying
     */ 
    function airdrop(address _recipient, uint256 _tokenId)
        external 
        onlyRole(AIRDROPPER_ROLE)
    {
        purchaseInternal(_recipient, _tokenId);
    }


    // INTERNAL

    function purchaseInternal(address _recipient, uint256 _tokenId) internal {
        _safeMint(_recipient, _tokenId);
        emit Purchase(_tokenId);
    }   

    // ADMIN

    function setPrice(uint256 _newPrice) external onlyRole(DEFAULT_ADMIN_ROLE) {
        price = _newPrice;
    }

    function setUri(string calldata _newUri) external onlyRole(DEFAULT_ADMIN_ROLE) {
        emit NewURI(baseUri, _newUri);
        baseUri = _newUri;
    }

    function withdraw() public onlyRole(DEFAULT_ADMIN_ROLE) {
        payable(msg.sender).transfer(address(this).balance);
    }

    // VIEW

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(0 < _tokenId && _tokenId < 101, "Token ID out of range of available tokens.");

        return string(abi.encodePacked(baseUri, _tokenId.toString())); 
    }
}