import socket
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    # Get host details
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    
    # Message with host details
    message = "Hello, World! Hostname: %s, IP Address: %s" % (hostname, ip_address)
    return message

if __name__ == "__main__":
    print("Starting the application...")
    # Get host details
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    
    # Print host details
    print("Host Details: Hostname: %s, IP Address: %s" % (hostname, ip_address))
    print("Message: %s" % "Hello, World!")
    
    # Run the Flask app
    app.run(host="0.0.0.0", port=5000)
