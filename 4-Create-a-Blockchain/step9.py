import datetime
import hashlib
import json

from flask import Flask

# Part 1 Building a Blockchain


class Blockchain:

    def __init__(self):
        self.chain = []
        # Create the Genesis block
        self.create_block(proof=1, previous_hash='0')

    def create_block(self, proof, previous_hash):
        block = {
            'index': len(self.chain) + 1,
            'timestamp': str(datetime.datetime.now()),
            'proof': proof,
            'previous_hash': previous_hash
        }

        self.chain.append(block)
        return block

    def get_previous_block(self):
        return self.chain[-1]

    def proof_of_work(self, previous_proof):
        new_proof = 1
        check_proof = False

        while check_proof is False:
            # Operation: non-symmetrical for uniqueness
            operation = str(new_proof**2 - previous_proof**2).encode()
            hash_operation = hashlib.sha256(operation).hexdigest()

            if hash_operation[:4] == "0000":
                check_proof = True
            else:
                new_proof += 1

        return new_proof

    def hash(self, block):
        # Step 1: Convert dictionary to JSON string
        encoded_block = json.dumps(block, sort_keys=True).encode()

        # Step 2 & 3: Hash using SHA256
        block_hash = hashlib.sha256(encoded_block).hexdigest()

        # Step 4: Return hash
        return block_hash

    def is_chain_valid(self, chain):
        previous_block = chain[0]
        block_index = 1

        while block_index < len(chain):
            block = chain[block_index]

            # Check 1: Previous hash
            if block['previous_hash'] != self.hash(previous_block):
                return False

            # Check 2: Proof of work
            previous_proof = previous_block['proof']
            proof = block['proof']
            hash_operation = hashlib.sha256(
                str(proof**2 - previous_proof**2).encode()).hexdigest()

            if hash_operation[:4] != '0000':
                return False

            # Update for next iteration
            previous_block = block
            block_index += 1

        return True


# Part 2 Mining our Blockchain

# Create the web app
app = Flask(__name__)

#  Create the blockchain
blockchain = Blockchain()
