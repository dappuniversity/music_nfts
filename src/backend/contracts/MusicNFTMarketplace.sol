// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract MusicNFTMarketplace is ERC721, Ownable {
    uint256 public _tokenIds;

    uint256 public immutable maxSupply;

    string public baseURI;
    string public baseExtension = ".json";

    address public artist;
    uint256 public royaltyFee;

    MarketItem[] public marketItems;

    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        uint256 price;
    }

    event MarketItemBought(
        uint256 indexed tokenId,
        address indexed seller,
        address buyer,
        uint256 price
    );
    event MarketItemRelisted(
        uint256 indexed tokenId,
        address indexed seller,
        uint256 price
    );

    constructor(
        uint256 _royaltyFee,
        address _artist,
        uint256[] memory _prices
    ) ERC721("DAppFi", "DAPP") payable {
      require(_prices.length*_royaltyFee <= msg.value, "Deployer must pay royalty fee for each token listed on the marketplace");
      baseURI = "https://bafybeidhjjbjonyqcahuzlpt7sznmh4xrlbspa3gstop5o47l6gsiaffee.ipfs.nftstorage.link/";
      royaltyFee = _royaltyFee;
      artist = _artist;
      maxSupply = _prices.length;
      for (uint8 i = 0; i < _prices.length; i++) {
        require(_prices[i] > 0, "Price must be greater than 0");
        _mint(address(this), i);
        marketItems.push(
            MarketItem(
              i,
              payable(msg.sender),
              _prices[i]
          )
        );
      }
    }

    /* Updates the listing price of the contract */
    function updateRoyaltyFee(uint256 _royaltyFee) public payable onlyOwner {
        royaltyFee = _royaltyFee;
    }

    /* Creates the sale of a marketplace item */
    /* Transfers ownership of the item, as well as funds between parties */
    function buyToken(uint256 _tokenId) public payable {
      uint256 price = marketItems[_tokenId].price;
      address seller = marketItems[_tokenId].seller;
      require(
        msg.value == price,
        "Please send the asking price in order to complete the purchase"
      );
      marketItems[_tokenId].seller = payable(address(0));
      _transfer(address(this), msg.sender, _tokenId);
      payable(artist).transfer(royaltyFee);
      payable(seller).transfer(msg.value);
      emit MarketItemBought(
        _tokenId,
        seller,
        msg.sender,
        price
      );
    }

    /* Allows someone to resell a token they have purchased */
    function resellToken(uint256 _tokenId, uint256 price) public payable {
        require(
          msg.value == royaltyFee,
          "Price must be equal to listing price"
        );
        require(
          price > 0,
          "Price must be greater than zero"
        );
        marketItems[_tokenId].price = price;
        marketItems[_tokenId].seller = payable(msg.sender);

        _transfer(msg.sender, address(this), _tokenId);
        emit MarketItemRelisted(
          _tokenId,
          msg.sender,
          price
      );
    }

    function getAllUnsoldTokens() external view returns(MarketItem[] memory){
      uint unsoldCount = balanceOf(address(this));
      MarketItem[] memory tokens = new MarketItem[] (unsoldCount);
      uint currentIndex;
      for(uint i = 0; i < marketItems.length; i++) {
        if(marketItems[i].seller != address(0)) {
          tokens[currentIndex] = marketItems[i];
          currentIndex++;
        }
      }
      return(tokens);
    }
    function getMyTokens() external view returns(MarketItem[] memory){
      uint myTokenCount = balanceOf(msg.sender);
      MarketItem[] memory tokens = new MarketItem[](myTokenCount);
      uint currentIndex;
      for(uint i = 0; i < marketItems.length; i++) {
        if(ownerOf(i) == msg.sender) {
          tokens[currentIndex] = marketItems[i];
          currentIndex++;
        }
      }
      return(tokens);
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
}
