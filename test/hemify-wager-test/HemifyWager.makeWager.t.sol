// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {HemifyWagerTest} from "./HemifyWager.t.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HemifyWagerMakeWagerTest is HemifyWagerTest {
    function testMakeWagerByNonOwner(address _addr) public {
        vm.assume(_addr != cOwner);
        vm.expectRevert();
        vm.prank(_addr);
        wager.makeWager(alice, IERC20(USDC), amount);

        assertEq(IERC20(USDC).balanceOf(address(hemifyTreasury)), 0);
    }

    function testMakeWagerByOwnerWithoutUSDCOrUSDT() public {
        vm.expectRevert();
        vm.prank(cOwner);
        wager.makeWager(alice, IERC20(WETH), amount);

        assertEq(IERC20(WETH).balanceOf(address(hemifyTreasury)), 0);
    }

    function testMakeWagerWithUSDC() public {
        vm.prank(alice);
        IERC20(USDC).approve(address(hemifyTreasury), amount);

        _allow(address(wager));

        vm.prank(cOwner);
        wager.makeWager(alice, IERC20(USDC), amount);

        assertEq(IERC20(USDC).balanceOf(address(hemifyTreasury)), amount);
    }

//    function testMakeWagerWithUSDT() public {
//        vm.prank(ian);
//        IERC20(USDT).approve(address(hemifyTreasury), amount);
//
//        _allow(address(wager));
//
//        vm.prank(cOwner);
//        wager.makeWager(ian, IERC20(USDT), amount);
//
//        assertEq(IERC20(USDT).balanceOf(address(hemifyTreasury)), amount);
//    }
}