// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {ERC721ACHMock} from "../utils/ERC721ACHMock.sol";
import {IERC721A} from "lib/ERC721A/contracts/IERC721A.sol";
import {AfterTokenTransfersHookMock} from "../utils/hooks/AfterTokenTransfersHookMock.sol";

contract AfterTokenTransfersHookTest is DSTest {
    Vm public constant vm = Vm(HEVM_ADDRESS);
    address public constant DEFAULT_OWNER_ADDRESS = address(0xC0FFEE);
    address public constant DEFAULT_BUYER_ADDRESS = address(0xBABE);
    ERC721ACHMock erc721Mock;
    AfterTokenTransfersHookMock hookMock;

    function setUp() public {
        erc721Mock = new ERC721ACHMock(DEFAULT_OWNER_ADDRESS);
        hookMock = new AfterTokenTransfersHookMock();
    }

    function test_afterTokenTransfersHook() public {
        assertEq(address(0), address(erc721Mock.afterTokenTransfersHook()));
    }

    function test_setAfterTokenTransfersHook() public {
        assertEq(address(0), address(erc721Mock.afterTokenTransfersHook()));

        // calling an admin function without being the contract owner should revert       
        vm.expectRevert();
        erc721Mock.setAfterTokenTransfersHook(hookMock);
        
        vm.prank(DEFAULT_OWNER_ADDRESS);
        erc721Mock.setAfterTokenTransfersHook(hookMock);
        assertEq(address(hookMock), address(erc721Mock.afterTokenTransfersHook()));
    }

     function test_afterTokenTransfersHook(
        uint256 startTokenId,
        uint256 quantity
    ) public {
        vm.assume(quantity > 0);
        vm.assume(startTokenId > 0);
        vm.assume(quantity < 10_000);
        vm.assume(quantity >= startTokenId);
       

        // Mint some tokens first
        test_setAfterTokenTransfersHook();
        erc721Mock.mint(DEFAULT_BUYER_ADDRESS, quantity);

        
        vm.prank(DEFAULT_BUYER_ADDRESS);
        erc721Mock.transferFrom(
            DEFAULT_BUYER_ADDRESS,
            DEFAULT_OWNER_ADDRESS,
            startTokenId
        );

        assertEq(DEFAULT_OWNER_ADDRESS, erc721Mock.ownerOf(startTokenId));

        // Verify hook override
        hookMock.setHooksEnabled(true);
        vm.expectRevert(
            AfterTokenTransfersHookMock.AfterTokenTransfersHook_Executed.selector
        );
        vm.prank(DEFAULT_OWNER_ADDRESS);
        erc721Mock.transferFrom(
            DEFAULT_OWNER_ADDRESS,
            DEFAULT_BUYER_ADDRESS,
            startTokenId
        );


    }




}
