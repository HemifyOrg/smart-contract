// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/**
* @title IEscrow
* @author fps (@0xfps).
* @dev  Escrow contract interface.
*       This interface controls the `Escrow` contract.
*/

interface IEscrow {

    error NotOwnerOrAuthorized();
    error TokenNotTransferred();
    error TokenNotOwned();

    function depositNFT(
        address from,
        IERC721 token,
        uint256 id
    ) external returns (bool);

    function sendNFT(
        IERC721 token,
        uint256 id,
        address to
    ) external returns (bool);
}