// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.25;

import { Test } from "forge-std/src/Test.sol";
import { console2 } from "forge-std/src/console2.sol";
import { RushHourSolver } from "../src/RushHourSolver.sol";
import { IRushHourSolver } from "../src/interface/IRushHourSolver.sol";
import { Helper } from "../src/libraries/Helper.sol";

contract RushHourSolverTest is Test {
    using Helper for uint256;

    RushHourSolver private rushHourSolver;

    function setUp() public {
        rushHourSolver = new RushHourSolver();
        console2.log("\n>>> Initial conditions");
    }

    function testSolveRushHourSolver() public view {
        uint8[6][6] memory inputData = getInputData(4);

        IRushHourSolver.Step[] memory steps = rushHourSolver.solve(inputData);

        for (uint256 i; i < steps.length; ++i) {
            string memory direction;
            if (steps[i].direction == IRushHourSolver.MovementDirection.Up) {
                direction = "Up";
            } else if (steps[i].direction == IRushHourSolver.MovementDirection.Right) {
                direction = "Right";
            } else if (steps[i].direction == IRushHourSolver.MovementDirection.Down) {
                direction = "Down";
            } else {
                direction = "Left";
            }

            string memory carIdStr = uint8ToString(steps[i].carId);
            string memory output = string.concat("Step(", carIdStr, ", MovementDirection.", direction, ")");
            console2.log(output);
        }
    }

    function uint8ToString(uint8 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint8 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint8(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }

    function getInputData(uint256 caseNum) public pure returns (uint8[6][6] memory inputData) {
        if (caseNum == 1) {
            inputData[0] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[1] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[2] = [uint8(1), uint8(1), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[3] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[4] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[5] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
        } else if (caseNum == 2) {
            inputData[0] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[1] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[2] = [uint8(1), uint8(1), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[3] = [uint8(0), uint8(2), uint8(2), uint8(2), uint8(0), uint8(0)];
            inputData[4] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[5] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
        } else if (caseNum == 3) {
            inputData[0] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[1] = [uint8(0), uint8(0), uint8(2), uint8(0), uint8(0), uint8(0)];
            inputData[2] = [uint8(1), uint8(1), uint8(2), uint8(3), uint8(0), uint8(0)];
            inputData[3] = [uint8(0), uint8(0), uint8(0), uint8(3), uint8(0), uint8(0)];
            inputData[4] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
            inputData[5] = [uint8(0), uint8(0), uint8(0), uint8(0), uint8(0), uint8(0)];
        } else {
            inputData[0] = [uint8(2), uint8(2), uint8(2), uint8(0), uint8(0), uint8(3)];
            inputData[1] = [uint8(0), uint8(0), uint8(4), uint8(0), uint8(0), uint8(3)];
            inputData[2] = [uint8(1), uint8(1), uint8(4), uint8(0), uint8(0), uint8(3)];
            inputData[3] = [uint8(5), uint8(0), uint8(4), uint8(0), uint8(6), uint8(6)];
            inputData[4] = [uint8(5), uint8(0), uint8(0), uint8(0), uint8(7), uint8(0)];
            inputData[5] = [uint8(8), uint8(8), uint8(8), uint8(0), uint8(7), uint8(0)];
        }
    }
}
