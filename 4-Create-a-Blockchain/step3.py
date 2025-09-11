
import datetime
import hashlib
import json
from flask import Flask, jsonify


class Blockchain:
    self.chain = []
    self.create_block(proof=1, previous_hash='0')
