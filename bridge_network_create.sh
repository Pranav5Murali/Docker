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

echo "Starting deployment..."

# Step 1: Verify local files
echo "Checking local repository files..."
ls -la "$LOCAL_REPO_PATH"

# Step 2: Clean remote directory and create new one
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  echo "Cleaning and setting up remote directory..."
  rm -rf $REMOTE_REPO_PATH
  mkdir -p $REMOTE_REPO_PATH
EOF

# Step 3: Copy repository files to the remote machine
echo "Copying files to the remote machine..."
sshpass -p "$SSH_PASSWORD" scp -rv "$LOCAL_REPO_PATH"/* "$REMOTE_USER@$REMOTE_IP:$REMOTE_REPO_PATH"

# Step 4: Verify files on the remote machine
echo "Verifying files on the remote machine..."
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  echo "Files in $REMOTE_REPO_PATH:"
  ls -la $REMOTE_REPO_PATH
EOF

# Step 5: Set permissions and execute the script
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  chmod +x $REMOTE_REPO_PATH/create_docker_network.py
  echo "Executing Python script..."
  python3 $REMOTE_REPO_PATH/create_docker_network.py
EOF

echo "Deployment completed!"
