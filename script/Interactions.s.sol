// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {
    string public constant TOKEN_URI =
        "ipfs://bafybeif3yfh7yu6a7pc5xmmvfpxiwigxmtvo2adn4dzsck3v2b3k2nch2q";

    string public constant METADATA_URI =
        "ipfs://bafybeicppznwoeobau5tavzbei6kdgzhsh2rukawk5o2qxn6hh7xdcrsti";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );

        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(METADATA_URI);
        vm.stopBroadcast();
    }
}
