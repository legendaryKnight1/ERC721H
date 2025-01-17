// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {IBalanceOfHook} from "./IBalanceOfHook.sol";
import {IOwnerOfHook} from "./IOwnerOfHook.sol";
import {ISafeTransferFromHook} from "./ISafeTransferFromHook.sol";
import {ITransferFromHook} from "./ITransferFromHook.sol";
import {IApproveHook} from "./IApproveHook.sol";
import {ISetApprovalForAllHook} from "./ISetApprovalForAllHook.sol";
import {IGetApprovedHook} from "./IGetApprovedHook.sol";
import {IIsApprovedForAllHook} from "./IIsApprovedForAllHook.sol";

interface IERC721ACH {
    /// @notice error onlyOwner
    error Access_OnlyOwner();

    /// @notice Emitted when balanceOf hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookBalanceOf(address indexed caller, address indexed hook);

    /// @notice Emitted when ownerOf hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookOwnerOf(address indexed caller, address indexed hook);

    /// @notice Emitted when safeTransferFrom hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookSafeTransferFrom(
        address indexed caller,
        address indexed hook
    );

    /// @notice Emitted when transferFrom hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookTransferFrom(address indexed caller, address indexed hook);

    /// @notice Emitted when approve hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookApprove(address indexed caller, address indexed hook);

    /// @notice Emitted when setApprovalForAll hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookSetApprovalForAll(
        address indexed caller,
        address indexed hook
    );

    /// @notice Emitted when getApproved hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookGetApproved(address indexed caller, address indexed hook);

    /// @notice Emitted when isApprovedForAll hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookIsApprovedForAll(
        address indexed caller,
        address indexed hook
    );

    /// @notice Emitted when setBeforeTokenTransfers hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookBeforeTokenTransfers(
        address indexed caller,
        address indexed hook
    );

    /// @notice Emitted when setBeforeTokenTransfers hook is set
    /// @param caller The caller
    /// @param hook The new hook
    event UpdatedHookAfterTokenTransfers(
        address indexed caller,
        address indexed hook
    );


    /// TODO
    function setBalanceOfHook(IBalanceOfHook _hook) external;

    /// TODO
    function setOwnerOfHook(IOwnerOfHook _hook) external;

    /// TODO
    function setSafeTransferFromHook(ISafeTransferFromHook _hook) external;

    /// TODO
    function setTransferFromHook(ITransferFromHook _hook) external;

    /// TODO
    function setApproveHook(IApproveHook _hook) external;

    /// TODO
    function setSetApprovalForAllHook(ISetApprovalForAllHook _hook) external;

    /// TODO
    function setGetApprovedHook(IGetApprovedHook _hook) external;

    /// TODO
    function setIsApprovedForAllHook(IIsApprovedForAllHook _hook) external;
}
