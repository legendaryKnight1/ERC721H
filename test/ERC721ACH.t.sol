// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;


import "forge-std/console.sol";
import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {ERC721ACHMock} from "./utils/ERC721ACHMock.sol";
import {IERC721A} from "lib/ERC721A/contracts/IERC721A.sol";
import {BalanceOfHookTest} from "./hooks/BalanceOfHook.t.sol";
import {IBalanceOfHook} from "../src/interfaces/IBalanceOfHook.sol";
import {IOwnerOfHook} from "../src/interfaces/IOwnerOfHook.sol";
import {ISafeTransferFromHook} from "../src/interfaces/ISafeTransferFromHook.sol";
import {ITransferFromHook} from "../src/interfaces/ITransferFromHook.sol";
import {IApproveHook} from "../src/interfaces/IApproveHook.sol";
import {ISetApprovalForAllHook} from "../src/interfaces/ISetApprovalForAllHook.sol";
import {IGetApprovedHook} from "../src/interfaces/IGetApprovedHook.sol";
import {IIsApprovedForAllHook} from "../src/interfaces/IIsApprovedForAllHook.sol";
import {IERC721ACH} from "../src/interfaces/IERC721ACH.sol";

contract ERC721ACHTest is DSTest {
    Vm public constant vm = Vm(HEVM_ADDRESS);
    address public constant DEFAULT_OWNER_ADDRESS = address(0x23499);
    address public constant DEFAULT_BUYER_ADDRESS = address(0x111);
    ERC721ACHMock erc721Mock;

    function setUp() public {
        vm.startPrank(DEFAULT_OWNER_ADDRESS);
        erc721Mock = new ERC721ACHMock(DEFAULT_OWNER_ADDRESS);
        vm.stopPrank();
    }

    function test_Erc721() public {
        assertEq("ERC-721ACH Mock", erc721Mock.name());
        assertEq("MOCK", erc721Mock.symbol());
    }

    function test_balanceOfHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.balanceOfHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setBalanceOfHook(IBalanceOfHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.balanceOfHook())
        );
    }

    function test_ownerOfHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.ownerOfHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setOwnerOfHook(IOwnerOfHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.ownerOfHook())
        );
    }

    function test_safeTransferFromHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.safeTransferFromHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setSafeTransferFromHook(ISafeTransferFromHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.safeTransferFromHook())
        );
    }

    function test_transferFromHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.transferFromHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setTransferFromHook(ITransferFromHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.transferFromHook())
        );
    }

    function test_approveHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.approveHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setApproveHook(IApproveHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.approveHook())
        );
    }

    function test_setApprovalForAllHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.setApprovalForAllHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setSetApprovalForAllHook(ISetApprovalForAllHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.setApprovalForAllHook())
        );
    }

    function test_getApprovedHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.getApprovedHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setGetApprovedHook(IGetApprovedHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.getApprovedHook())
        );
    }

    function test_isApprovedForAllHook(address hook, address caller) public {
        assertEq(address(0), address(erc721Mock.isApprovedForAllHook()));
        bool isOwner = caller == DEFAULT_OWNER_ADDRESS;
        vm.prank(caller);
        if (!isOwner) {
            vm.expectRevert(IERC721ACH.Access_OnlyOwner.selector);
        }
        erc721Mock.setIsApprovedForAllHook(IIsApprovedForAllHook(hook));
        assertEq(
            isOwner ? hook : address(0),
            address(erc721Mock.isApprovedForAllHook())
        );
    }

        function test_gasEstimateForSingleMint() public {
        address buyer = address(0x1111);
        console.logString(
            "=====================gas estimation for minting single NFT=========================="
        );
        uint originGasLeft;
        uint gasDelta;
        originGasLeft = gasleft();
        erc721Mock.mint(buyer, 1);
        gasDelta = originGasLeft - gasleft() - 100;
        console.log("gasDelta: %d", gasDelta);
    }

    function test_gasEstimateForMint2NFTs() public {
        address buyer = address(0x1111);
        console.logString(
            "=====================gas estimation for minting 2 NFT=========================="
        );
        uint originGasLeft;
        uint gasDelta;
        originGasLeft = gasleft();
        erc721Mock.mint(buyer, 2);
        gasDelta = originGasLeft - gasleft() - 100;
        console.log("gasDelta: %d", gasDelta);
    }

    function test_gasEstimateForMint3NFTs() public {
        address buyer = address(0x1111);
        console.logString(
            "=====================gas estimation for minting 3 NFT=========================="
        );
        uint originGasLeft;
        uint gasDelta;
        originGasLeft = gasleft();
        erc721Mock.mint(buyer, 3);
        gasDelta = originGasLeft - gasleft() - 100;
        console.log("gasDelta: %d", gasDelta);
    }
}
