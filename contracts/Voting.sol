pragma solidity ^0.4.23;

import './ECVerify.sol';

contract Voting {

    // commtiments[proposalId][user] = commitment
    mapping ( uint => mapping ( address => bytes32 ) ) commitments;
    event Revealed(address indexed voter, uint indexed proposalId, uint indexed vote);

    using ECVerify for bytes32;

    function submitVote(uint proposalId, bytes32 commitment) external { 
        commitments[proposalId][msg.sender] = commitment;
    }

    function revealVote(uint proposalId, uint vote, bytes sig) external {
        // Get commitment from sent data
        bytes32 commitment = keccak256(proposalId, vote); 

        // Verify that data is correct
        require(
            commitments[proposalId][msg.sender] == commitment,
            "Wrong commitment"
        );

        // Verify that signature of message is correct. Needs geth prefix
        // utilizing the library and `Using .. for` syntax this can read very nicely
        require(
            prefixed(commitment).ecverify(sig, msg.sender), 
            "Invalid signature"
        );

        // Do whatever.
        emit Revealed(msg.sender, proposalId, vote);
    }

    function prefixed(bytes32 hash) private pure returns (bytes32) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        return keccak256(prefix, hash);
    }
}
