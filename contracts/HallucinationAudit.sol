// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HallucinationAudit {
    struct AuditEntry {
        uint256 round;
        string nodeHash;
        string modelHash;
        string answerHash;
        string groundTruthHash;
        bool hallucinated;
        uint256 penaltyApplied;
        uint256 timestamp;
    }

    struct NodeStatus {
        uint256 totalPenalties;
        uint256 hallucinationCount;
        uint256 cleanCount;
        bool exists;
    }

    address public owner;
    AuditEntry[] private auditTrail;
    mapping(string => NodeStatus) private nodeStatus;

    event AuditRecorded(
        uint256 indexed auditIndex,
        uint256 indexed round,
        string indexed nodeHash,
        string modelHash,
        bool hallucinated,
        uint256 penaltyApplied
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can record audits");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function recordAudit(
        uint256 _round,
        string memory _nodeHash,
        string memory _modelHash,
        string memory _answerHash,
        string memory _groundTruthHash,
        bool _hallucinated,
        uint256 _penaltyAmount
    ) external onlyOwner {
        uint256 appliedPenalty = _hallucinated ? _penaltyAmount : 0;

        auditTrail.push(
            AuditEntry({
                round: _round,
                nodeHash: _nodeHash,
                modelHash: _modelHash,
                answerHash: _answerHash,
                groundTruthHash: _groundTruthHash,
                hallucinated: _hallucinated,
                penaltyApplied: appliedPenalty,
                timestamp: block.timestamp
            })
        );

        NodeStatus storage status = nodeStatus[_nodeHash];
        status.exists = true;

        if (_hallucinated) {
            status.totalPenalties += appliedPenalty;
            status.hallucinationCount += 1;
        } else {
            status.cleanCount += 1;
        }

        emit AuditRecorded(
            auditTrail.length - 1,
            _round,
            _nodeHash,
            _modelHash,
            _hallucinated,
            appliedPenalty
        );
    }

    function getAuditCount() external view returns (uint256) {
        return auditTrail.length;
    }

    function getAuditEntry(uint256 index) external view returns (AuditEntry memory) {
        require(index < auditTrail.length, "Invalid audit index");
        return auditTrail[index];
    }

    function getNodeStatus(
        string memory _nodeHash
    )
        external
        view
        returns (
            uint256 totalPenalties,
            uint256 hallucinationCount,
            uint256 cleanCount,
            bool exists
        )
    {
        NodeStatus memory status = nodeStatus[_nodeHash];
        return (
            status.totalPenalties,
            status.hallucinationCount,
            status.cleanCount,
            status.exists
        );
    }
}
