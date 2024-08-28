// SPDX-License-Identifier: MIT
// We use a floating point pragma here so it can be used within other projects that interact with the zkSync ecosystem without using our exact pragma version.
pragma solidity ^0.8.21;

import {IVerifier, VerifierParams} from "./IVerifier.sol";
import {FeeParams} from "../chain-deps/ZkSyncHyperchainStorage.sol";

/// @param chainId the id of the chain
/// @param bridgehub the address of the bridgehub contract
/// @param stateTransitionManager contract's address
/// @param protocolVersion initial protocol version
/// @param validatorTimelock address of the validator timelock that delays execution
/// @param admin address who can manage the contract
/// @param baseToken address of the base token of the chain
/// @param baseTokenBridge address of the L1 shared bridge contract
/// @param storedBatchZero hash of the initial genesis batch
/// @param verifier address of Verifier contract
/// @param verifierParams Verifier config parameters that describes the circuit to be verified
/// @param l2BootloaderBytecodeHash The hash of bootloader L2 bytecode
/// @param l2DefaultAccountBytecodeHash The hash of default account L2 bytecode
/// @param priorityTxMaxGasLimit maximum number of the L2 gas that a user can request for L1 -> L2 transactions
/// @param feeParams Fee parameters to be used for L1->L2 transactions
/// @param blobVersionedHashRetriever Address of contract used to pull the blob versioned hash for a transaction.
/// @param batchCommitDeadline The deadline to commit a batch
// solhint-disable-next-line gas-struct-packing
struct InitializeData {
    uint256 chainId;
    address bridgehub;
    address stateTransitionManager;
    uint256 protocolVersion;
    address admin;
    address validatorTimelock;
    address baseToken;
    address baseTokenBridge;
    bytes32 storedBatchZero;
    IVerifier verifier;
    VerifierParams verifierParams;
    bytes32 l2BootloaderBytecodeHash;
    bytes32 l2DefaultAccountBytecodeHash;
    uint256 priorityTxMaxGasLimit;
    FeeParams feeParams;
    address blobVersionedHashRetriever;
    uint256 batchCommitDeadline;
}

/// @param verifier address of Verifier contract
/// @param verifierParams Verifier config parameters that describes the circuit to be verified
/// @param l2BootloaderBytecodeHash The hash of bootloader L2 bytecode
/// @param l2DefaultAccountBytecodeHash The hash of default account L2 bytecode
/// @param priorityTxMaxGasLimit maximum number of the L2 gas that a user can request for L1 -> L2 transactions
/// @param feeParams Fee parameters to be used for L1->L2 transactions
/// @param blobVersionedHashRetriever Address of contract used to pull the blob versioned hash for a transaction.
struct InitializeDataNewChain {
    IVerifier verifier;
    VerifierParams verifierParams;
    bytes32 l2BootloaderBytecodeHash;
    bytes32 l2DefaultAccountBytecodeHash;
    uint256 priorityTxMaxGasLimit;
    FeeParams feeParams;
    address blobVersionedHashRetriever;
    uint256 batchCommitDeadline;
}

interface IDiamondInit {
    function initialize(InitializeData calldata _initData) external returns (bytes32);
}
