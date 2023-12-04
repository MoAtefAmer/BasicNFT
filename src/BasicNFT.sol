// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint private s_tokenCounter;
    mapping (uint => string) private s_tokenToIdUri ;
    constructor() ERC721("Snoop", "DOGG") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        
        s_tokenToIdUri[s_tokenCounter] = tokenUri;   
        _safeMint(msg.sender, s_tokenCounter); 
        s_tokenCounter++;

    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenToIdUri[tokenId];
    }


    
}
