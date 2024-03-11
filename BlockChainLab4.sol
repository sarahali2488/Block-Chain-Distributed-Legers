// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*------------------Merkle Tree------------
Functions used in this code:

- abi.encodePacked: This function is used to encode the given arguments into a tightly packed byte array. 
It takes a variable number of arguments of any type and returns a byte array containing the concatenation 
of the encoded arguments.

- keccak256: This function computes the Keccak-256 hash of its input. 
It takes a single bytes parameter and returns a 32-byte hash (uint256 in Solidity).*/
//////////////////////////////////////////////////////////////////////////////////////////

// Function to verify a Merkle proof
contract MerkleProof {
    
    function verify(
        bytes32[] memory proof,  // Merkle proof array containing sibling nodes
        bytes32 root,            // Root hash of the Merkle tree
        bytes32 leaf,            // Hash of the leaf node being proven
        uint256 index             // Index of the leaf node in the Merkle tree
    ) public pure returns (bool) {
        bytes32 hash = leaf;  // Initialize hash with the hash of the leaf node being proven

        // Iterate through each proof element (sibling node)
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];  // Get the current proof element (sibling node)

            // Check if the current leaf node is the left or right child in its parent node
            if (index % 2 == 0) {
                // If the index is even, concatenate current leaf hash and proof element on the left
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                // If the index is odd, concatenate proof element and current leaf hash on the left
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;  // Move up one level in the Merkle tree (parent node index)
        }

        // Check if the final computed hash matches the provided Merkle root
        return hash == root;
    }
}


//The contract TestMerkleProof inherits from the MerkleProof contract.
contract TestMerkleProof is MerkleProof {
    // Array to store Merkle tree nodes
    bytes32[] public hashes;

    constructor() {
        // Array of transactions
        string[4] memory transactions =
            ["alice -> bob", "bob -> dave", "carol -> alice", "dave -> bob"];

        // Compute leaf node hashes and build the Merkle tree
        for (uint256 i = 0; i < transactions.length; i++) {

            // Compute the hash of each transaction and add it to the hashes array
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        //Leaf nodes number as the transactions' array length
        uint256 n = transactions.length;

        //offset for combining nodes in the Merkle tree
        uint256 offset = 0;

        // Build the Merkle tree
        while (n > 0) {
            //For loop to concatenate two child nodes and add it to the hashes array
            for (uint256 i = 0; i < n - 1; i += 2) {
                hashes.push(
                    keccak256(
                        abi.encodePacked(
                            hashes[offset + i], hashes[offset + i + 1]
                        )
                    )
                );
            }
            offset += n; // Move to the next level in the Merkle tree
            n = n / 2; // Reduce the number of nodes by half for the next level
        }
    }

    //Function to get the root hash of the Merkle tree 
    function getRoot() public view returns (bytes32) {
        return hashes[hashes.length - 1]; //To return the last element in the hashes array, which is the root hash
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
/*resource: https://solidity-by-example.org/app/merkle-tree/*/