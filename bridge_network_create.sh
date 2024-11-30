#!/bin/bash

# Get the password from the argument
SSH_PASSWORD="$1"

# Define the remote user and IP address
REMOTE_USER="user1"
REMOTE_IP="192.168.1.105"

# Git repository and branch details
GIT_REPO="https://github.com/Pranav5Murali/Docker.git"
REPO_PATH="/home/user1/Docker"

# Connect to the remote machine and execute commands
echo "Connecting to the remote machine and setting up the Docker network..."
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  # Remove any existing repository clone
  echo "Cleaning up old repository..."
  rm -rf $REPO_PATH

  # Clone the repository
  echo "Cloning the repository..."
  git clone $GIT_REPO $REPO_PATH

  # Navigate to the repository and execute the Python script
  echo "Executing the Python script to create the Docker network..."
  python3 $REPO_PATH/create_docker_network.py
EOF

echo "Script execution completed!"
