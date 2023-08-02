// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;
    string public constant CREATIVE_SVG_URI =
        "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjUwMCIgaGVpZ2h0PSI1MDAiPgo8cGF0aCBzdHJva2Utd2lkdGg9IjY2IiBzdHJva2U9IiMwMDAiIHN0cm9rZS1kYXNoYXJyYXk9IjYiIGQ9Im0zNSwydjY2Ii8+Cjwvc3ZnPgo=";
    string public constant UNION_SVG_URI =
        "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4gCjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+CjxwYXRoIHN0cm9rZS13aWR0aD0iNiIgc3Ryb2tlPSIjMDAwIiBkPSJtMiw1aDI4bTEwLDBoMjhtMCwxMkgybTAKMTJoMjhtMTAsMGgyOG0wLDEySDQwbS0xMCwwSDJtMCwxMkgzMG0xMCwwSDY4bTAsMTJINDBtLTEwLDBIMiIvPgo8L3N2Zz4K";
    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(CREATIVE_SVG_URI, UNION_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}
