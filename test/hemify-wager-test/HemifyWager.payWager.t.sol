// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {HemifyWagerTest} from "./HemifyWager.t.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HemifyWagerPayWagerTest is HemifyWagerTest {
    uint256 internal pay = 4 ether;

    function testPayWagerByNonOwner(address _addr) public {
        vm.assume(_addr != cOwner);

        _makeWager();

        vm.expectRevert();
        vm.prank(_addr);
        wager.payWager(IERC20(USDC), chris, pay);
    }

    function testPayWagerWithNonUSDCOrUSDT() public {
        _makeWager();

        vm.expectRevert();
        vm.prank(cOwner);
        wager.payWager(IERC20(WETH), chris, pay);
    }

    function testPayWagerWithUSDC() public {
        _makeWager();

        vm.prank(cOwner);
        wager.payWager(IERC20(USDC), chris, pay);

        assertEq(IERC20(USDC).balanceOf(chris), (pay - ((45 * pay) / 1000)));
    }

//    function testPayWagerWithUSDT() public {
//        vm.prank(cOwner);
//        wager.payWager(IERC20(USDT), chris, pay);
//
//        assertTrue(IERC20(USDT).balanceOf(chris) != 0);
//    }

    function _makeWager() public {
        vm.prank(alice);
        IERC20(USDC).approve(address(hemifyTreasury), amount);

        _allow(address(wager));

        vm.prank(cOwner);
        wager.makeWager(alice, IERC20(USDC), amount);
    }
}