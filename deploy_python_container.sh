#!/bin/bash

# Arguments
SSH_PASSWORD="$1"
REMOTE_USER="user1"
REMOTE_IP="192.168.1.105"
REMOTE_PATH="/home/user1/Docker"



# Step 2: Copy all files to the VM
echo "Copying project files to Slava VM..."
sshpass -p "$SSH_PASSWORD" scp -r * "$REMOTE_USER@$REMOTE_IP:$REMOTE_PATH"

# Step 3: Run the Python script to deploy the container
echo "Executing Python script to deploy the container on Slava VM..."
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_IP" <<EOF
  cd $REMOTE_PATH
  python3 create_python_container.py
EOF

echo "Deployment to Slava VM completed!"
