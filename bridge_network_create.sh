#!/bin/bash

# Get the password from the argument
SSH_PASSWORD="$1"

# Define the remote user and IP address
REMOTE_USER="user1"
REMOTE_IP="192.168.1.105"

# Local repository path (current directory, repository root)
LOCAL_REPO_PATH="."

# Remote path to copy the files
REMOTE_REPO_PATH="/home/user1/Docker"

# Connect to the remote machine and execute commands
echo "Connecting to the remote machine and setting up the Docker network..."

# Step 1: Ensure the repository files are prepared locally
if [ ! -d "$LOCAL_REPO_PATH" ]; then
  echo "Error: Local repository path '$LOCAL_REPO_PATH' does not exist."
  exit 1
fi

# Step 2: Remove any existing repository files on the remote machine
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  echo "Cleaning up old repository on remote machine..."
  rm -rf $REMOTE_REPO_PATH
EOF
  whoami
  uname -a
  hostname -i

# Step 3: Copy the repository files to the remote machine using scp
echo "Copying repository files to the remote machine..."
sshpass -p "$SSH_PASSWORD" scp -r "$LOCAL_REPO_PATH"/* "$REMOTE_USER@$REMOTE_IP:$REMOTE_REPO_PATH"

# Step 4: Connect to the remote machine and execute the script
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF

  # Ensure the Python script is executable
  echo "Setting executable permissions for the Python script..."
  chmod +x $REMOTE_REPO_PATH/create_docker_network.py

  # Navigate to the repository and execute the Python script
  echo "Executing the Python script to create the Docker network..."
  python3 $REMOTE_REPO_PATH/create_docker_network.py
EOF

echo "Script execution completed!"

