pragma solidity ^0.8.10;

interface IGSafe {
    event AddedOwner(address indexed owner);
    event ApproveHash(bytes32 indexed approvedHash, address indexed owner);
    event ChangedFallbackHandler(address indexed handler);
    event ChangedGuard(address indexed guard);
    event ChangedThreshold(uint256 threshold);
    event DisabledModule(address indexed module);
    event EnabledModule(address indexed module);
    event ExecutionFailure(bytes32 indexed txHash, uint256 payment);
    event ExecutionFromModuleFailure(address indexed module);
    event ExecutionFromModuleSuccess(address indexed module);
    event ExecutionSuccess(bytes32 indexed txHash, uint256 payment);
    event RemovedOwner(address indexed owner);
    event SafeReceived(address indexed sender, uint256 value);
    event SafeSetup(
        address indexed initiator, address[] owners, uint256 threshold, address initializer, address fallbackHandler
    );
    event SignMsg(bytes32 indexed msgHash);

    function VERSION() external view returns (string memory);
    function addOwnerWithThreshold(address owner, uint256 _threshold) external;
    function approveHash(bytes32 hashToApprove) external;
    function approvedHashes(address, bytes32) external view returns (uint256);
    function changeThreshold(uint256 _threshold) external;
    function checkNSignatures(bytes32 dataHash, bytes memory data, bytes memory signatures, uint256 requiredSignatures)
        external
        view;
    function checkSignatures(bytes32 dataHash, bytes memory data, bytes memory signatures) external view;
    function disableModule(address prevModule, address module) external;
    function domainSeparator() external view returns (bytes32);
    function enableModule(address module) external;
    function encodeTransactionData(
        address to,
        uint256 value,
        bytes memory data,
        uint8 operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address refundReceiver,
        uint256 _nonce
    ) external view returns (bytes memory);
    function execTransaction(
        address to,
        uint256 value,
        bytes memory data,
        uint8 operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address refundReceiver,
        bytes memory signatures
    ) external payable returns (bool success);
    function execTransactionFromModule(address to, uint256 value, bytes memory data, uint8 operation)
        external
        returns (bool success);
    function execTransactionFromModuleReturnData(address to, uint256 value, bytes memory data, uint8 operation)
        external
        returns (bool success, bytes memory returnData);
    function getChainId() external view returns (uint256);
    function getModulesPaginated(address start, uint256 pageSize)
        external
        view
        returns (address[] memory array, address next);

    function signedMessages(bytes32) external view returns (uint256);
    function simulateAndRevert(address targetContract, bytes memory calldataPayload) external;
    function swapOwner(address prevOwner, address oldOwner, address newOwner) external;

    //// ################
    function addOwner(address who_) external returns (bool);
    function removeOwner(address who_) external returns (bool);

    function parentAddress() external view returns (address);

    function getThreshold() external view returns (uint256);
    function getOwners() external view returns (address[] memory);

    function getOwnerCount() external view returns (uint256);
    function isOwner(address who_) external view returns (bool);
}
