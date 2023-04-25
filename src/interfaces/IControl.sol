// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import {AggregatorV3Interface}
    from "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/**
* @title IControl
* @author fps (@0xfps).
* @dev  Control contract interface.
*       This interface controls the `Control` contract.
*/

interface IControl {
    /// @dev    Events for different supports and revokes.
    /// @notice nft NFT address supported or revoked.
    /// @notice token IERC20 token address supported or revoked.
    event TokenSupportedForAuction(IERC20 indexed token);
    event TokenRevokedForAuction(IERC20 indexed token);

    error ZeroAddress();

    function supportToken(IERC20 token, AggregatorV3Interface agg) external;
    function revokeToken(IERC20 token) external;

    function isSupported(IERC20 token) external view returns (address);
}