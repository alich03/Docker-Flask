from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # To handle CORS issues



@app.route('/', methods=['GET'])
def test():
    return jsonify({'response': 'API IS RUNNING'})
