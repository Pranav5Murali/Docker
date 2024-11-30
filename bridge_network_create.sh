#!/bin/bash

# Get the password from the argument
SSH_PASSWORD="$1"

# Define the remote user and IP address
REMOTE_USER="user1"
REMOTE_IP="192.168.1.105"

# Path to the Python script
PYTHON_SCRIPT_PATH="./create_docker_network.py"

# Upload the Python script to the remote machine
echo "Uploading the Python script to the remote machine..."
sshpass -p "$SSH_PASSWORD" scp "$PYTHON_SCRIPT_PATH" "$REMOTE_USER@$REMOTE_IP:/home/user1/"

# Execute the Python script on the remote machine
echo "Executing the Python script on the remote machine..."
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" "python3 /home/user1/create_docker_network.py"


echo "Script execution completed!"
