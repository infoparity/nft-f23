// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_creativeSvgImageUri;
    string private s_unionSvgImageUri;

    enum Mood {
        CREATIVE,
        UNION
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory creativeSvgImageUri,
        string memory unionSvgImageUri
    ) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_creativeSvgImageUri = creativeSvgImageUri;
        s_unionSvgImageUri = unionSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.CREATIVE;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.CREATIVE) {
            s_tokenIdToMood[tokenId] = Mood.UNION;
        } else {
            s_tokenIdToMood[tokenId] = Mood.CREATIVE;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.CREATIVE) {
            imageURI = s_creativeSvgImageUri;
        } else {
            imageURI = s_unionSvgImageUri;
        }

        // formatting our json object and base64 svg
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description":  "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
