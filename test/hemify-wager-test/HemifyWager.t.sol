// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "forge-std/Test.sol";
import {Addresses} from "../data/Addresses.t.sol";

import {HemifyTreasury} from "../../src/contracts/HemifyTreasury.sol";
import {HemifyWager} from "../../src/contracts/hemify-wager/HemifyWager.sol";

contract HemifyWagerTest is Test, Addresses {
    address internal constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address internal constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    HemifyTreasury internal hemifyTreasury;
    HemifyWager internal wager;
    uint256 internal currentFork = 10;

    uint256 internal amount = 10 ether;
    uint256 internal limit = 100 ether;

    function setUp() public {
        currentFork = vm.createSelectFork("https://rpc.ankr.com/eth");
        address[] memory _addresses = _setupAddresses(7);

        vm.expectRevert();
        wager = new HemifyWager(address(hemifyTreasury));

        vm.startPrank(cOwner);
        hemifyTreasury = new HemifyTreasury(_addresses);
        wager = new HemifyWager(address(hemifyTreasury));
        vm.stopPrank();

        deal(USDC, alice, limit);
        deal(USDT, ian, limit);
    }

    function testSetUp() public {
        assertTrue(address(hemifyTreasury) != address(0));
        assertTrue(currentFork != 10);
        assertTrue(address(wager) != address(0));
        assertEq(IERC20(USDC).balanceOf(alice), limit);
        assertEq(IERC20(USDT).balanceOf(ian), limit);
    }

    function _allow(address _address) internal {
        for (uint i; i != 7; ) {
            vm.startPrank(addresses_[i]);
            hemifyTreasury.sign();
            vm.stopPrank();

            unchecked { ++i; }
        }

        vm.prank(cOwner);
        hemifyTreasury.allow(_address);
    }

    function _disAllow(address _address) internal {
        for (uint i; i != 7; ) {
            vm.startPrank(addresses_[i]);
            hemifyTreasury.sign();
            vm.stopPrank();

            unchecked { ++i; }
        }

        vm.prank(cOwner);
        hemifyTreasury.disAllow(_address);
    }
}