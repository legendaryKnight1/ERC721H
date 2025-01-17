// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {ERC721ACHMock} from "../utils/ERC721ACHMock.sol";
import {IERC721A} from "lib/ERC721A/contracts/IERC721A.sol";
import {ApproveHookMock} from "../utils/hooks/ApproveHookMock.sol";

contract ApproveHookTest is DSTest {
    Vm public constant vm = Vm(HEVM_ADDRESS);
    address public constant DEFAULT_OWNER_ADDRESS = address(0x23499);
    address public constant DEFAULT_BUYER_ADDRESS = address(0x111);
    ERC721ACHMock erc721Mock;
    ApproveHookMock hookMock;

    function setUp() public {
        erc721Mock = new ERC721ACHMock(DEFAULT_OWNER_ADDRESS);
        hookMock = new ApproveHookMock();
    }

    function test_approveHook() public {
        assertEq(address(0), address(erc721Mock.approveHook()));
    }

    function test_setApproveHook() public {
        assertEq(address(0), address(erc721Mock.approveHook()));
        vm.prank(DEFAULT_OWNER_ADDRESS);
        erc721Mock.setApproveHook(hookMock);
        assertEq(address(hookMock), address(erc721Mock.approveHook()));
    }

    function test_approve(
        uint256 _mintQuantity,
        uint256 _tokenToApprove
    ) public {
        vm.assume(_mintQuantity > 0);
        vm.assume(_tokenToApprove > 0);
        vm.assume(_mintQuantity < 10_000);
        vm.assume(_tokenToApprove <= _mintQuantity);

        // Mint some tokens first
        erc721Mock.mint(DEFAULT_BUYER_ADDRESS, _mintQuantity);

        // Verify normal functionality
        assertEq(address(0), erc721Mock.getApproved(_tokenToApprove));
        vm.prank(DEFAULT_BUYER_ADDRESS);
        erc721Mock.approve(DEFAULT_OWNER_ADDRESS, _tokenToApprove);
        assertEq(
            DEFAULT_OWNER_ADDRESS,
            erc721Mock.getApproved(_tokenToApprove)
        );

        // Verify hook override
        test_setApproveHook();
        hookMock.setHooksEnabled(true);
        vm.expectRevert(ApproveHookMock.ApproveHook_Executed.selector);
        vm.prank(DEFAULT_BUYER_ADDRESS);
        erc721Mock.approve(DEFAULT_OWNER_ADDRESS, _tokenToApprove);
    }
}
