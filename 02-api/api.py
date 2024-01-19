from flask import Flask, jsonify
app = Flask(__name__)

addresses = [
    { 'email': 'john_doe@gmail.com', 'city': 'Chicago', 'state': 'IL' },
	{ 'email': 'jane_doe@gmail.com', 'city': 'Annapolis', 'state': 'MD' },
]

@app.route('/')
def hello():
	return "Hello World!"

@app.route('/addresses')
def get_addresses():
    return jsonify(addresses)

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8000)