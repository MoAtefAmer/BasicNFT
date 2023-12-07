// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        console.log("sadSvg", sadSvg);

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(sadSvg, happySvg);
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public view returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        string memory imageURI = string(
            abi.encodePacked(baseURL, svgBase64Encoded)
        );
        console.log("imageURI", imageURI);
        return imageURI;
    }
}
