// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT__CantFlipMoodIfNotOwner();

    uint private s_tokenCounter;
    string private s_sadSvgImageURI;
    string private s_happySvgImageURI;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageURI,
        string memory happySvgImageURI
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageURI = happySvgImageURI;
        s_sadSvgImageURI = sadSvgImageURI;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    
    function flipMood(uint tokenID) public {
        // only want nft owner to be able to flip mood
       if (getApproved(tokenID) != msg.sender && ownerOf(tokenID) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenID] == Mood.HAPPY) {
            s_tokenIdToMood[tokenID] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenID] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint tokenID
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenID] == Mood.HAPPY) {
            imageURI = s_happySvgImageURI;
        } else {
            imageURI = s_sadSvgImageURI;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '","description":"An NFT that reflects the owners mood","attributes":[{trait_type:"moodiness","value":100}],"image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
