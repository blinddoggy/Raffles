// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RifaNFT is ERC721URIStorage, Ownable {
    using SafeMath for uint256;

    IERC20 public usdt; // Contrato del token USDT
    uint256 public nextTokenId = 1;
    uint256 public precio = 2 * 10**6; // Precio del NFT en USDT (asumiendo que USDT tiene 6 decimales)

    constructor(address _usdt) ERC721("RifaNFT", "RNFT") {
        usdt = IERC20(_usdt);
    }

    // Función para acuñar NFT
    function mintNFT(string memory uri) external onlyOwner {
        _mint(address(this), nextTokenId);
        _setTokenURI(nextTokenId, uri);
        nextTokenId = nextTokenId.add(1);
    }

    // Función para comprar NFT
    function comprarNFT(uint256 tokenId) external {
        //require(_exists(tokenId), "NFT no existe");
        //require(usdt.transferFrom(msg.sender, owner(), precio), "Fallo en la transferencia de USDT");

        _transfer(address(this), msg.sender, tokenId);
    }
}
