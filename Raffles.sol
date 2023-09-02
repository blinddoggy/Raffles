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
    uint256 public precio = 1; // Precio del NFT en wei

    constructor(address _usdtAddress) ERC721("RifaNFT", "RNFT") {
        usdt = IERC20(_usdtAddress);
    }

   // Función para acuñar NFT
    function crearBoleta(string memory uri) external onlyOwner {
        _mint(address(this), nextTokenId);
        _setTokenURI(nextTokenId, uri);
        nextTokenId = nextTokenId.add(1);
    }

    // Función para comprar NFT
    function transferirBoleta(uint256 tokenId) external payable {
        _transfer(address(this), msg.sender, tokenId);
    }

  // Función para depositar USDT en el contrato
    function transferirUSDT(uint256 amount) public  {
        require(
            usdt.transferFrom(msg.sender, address(this), amount),
            "Transferencia de USDT fallida"
        );
    }

    // Función para retirar USDT del contrato
    function retirarUSDT(uint256 amount) public {
        require(usdt.transfer(msg.sender, amount), "Retirada de USDT fallida");
    }
  
    // Función para comprar NFT
    function comprarBoleta(uint256 tokenId) external payable {

        transferirUSDT(precio * 1e6);

        _transfer(address(this), msg.sender, tokenId);
    }

  

   
}
