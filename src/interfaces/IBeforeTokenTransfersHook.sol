// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/// @title IBeforeTokenTransfersHook
/// @dev Interface that defines hooks to be executed before token transfers.
interface IBeforeTokenTransfersHook {

    /**
        @notice Emitted when the before token transfers hook is used.
        @param from Address from which the tokens are being transferred.
        @param to Address to which the tokens are being transferred.
        @param startTokenId The starting ID of the tokens being transferred.
        @param quantity The number of tokens being transferred.
    
     */
    event BeforeTokenTransfersHookUsed(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    );

    /**
        @notice Checks if the token transfers function should use the custom hook.
        @param from Address from which the tokens are being transferred.
        @param to Address to which the tokens are being transferred.
        @param startTokenId The starting ID of the tokens being transferred.
        @param quantity The number of tokens being transferred.
        @return A boolean indicating whether or not to use the custom hook for the token transfers function.
        
     */
    function useBeforeTokenTransfersHook(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) external view returns (bool);

    /**
        @notice Provides a custom implementation for the token transfers process.
        @param from Address from which the tokens are being transferred.
        @param to Address to which the tokens are being transferred.
        @param startTokenId The starting ID of the tokens being transferred.
        @param quantity The number of tokens being transferred.
            
     */
    function beforeTokenTransfersOverrideHook(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) external;
}
