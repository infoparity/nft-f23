// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string
            memory expectedUri = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHBhdGggc3Ryb2tlLXdpZHRoPSI2NiIgc3Ryb2tlPSIjMDAwIiBzdHJva2UtZGFzaGFycmF5PSI2IiBkPSJtMzUsMnY2NiIvPjwvc3ZnPgo=";
        string
            memory svg = '<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><path stroke-width="66" stroke="#000" stroke-dasharray="6" d="m35,2v66"/></svg>';
        string memory actualUri = deployer.svgToImageURI(svg);
        console.log(actualUri);
        console.log(expectedUri);
        assert(
            keccak256(abi.encodePacked(expectedUri)) ==
                keccak256(abi.encodePacked(actualUri))
        );
    }
}
