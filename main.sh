#!/bin/bash

# Set timezone
TZ=Europe/London && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
apt-get update && apt-get install -y -qq wget curl git

# Install Docker if not already installed
if ! [ -x "$(command -v docker)" ]; then
  curl -fsSL https://get.docker.com | sh
  systemctl start docker
  systemctl enable docker
fi

# Pull the Arbitrum Nitro node Docker image
docker pull offchainlabs/nitro-node:v2.0.10-73224e3

# Create necessary directories
mkdir -p /root/.arbitrum

# If an SSH password is provided, install and configure SSH
if [[ -n $SSH_PASS ]]; then
  apt-get install -y ssh
  echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
  (echo $SSH_PASS; echo $SSH_PASS) | passwd root
  service ssh restart
fi

# Define the Docker run command for the Nitro node
DOCKER_CMD="docker run --rm -it \
  -v /root/.arbitrum:/home/user/.arbitrum \
  -p 8547:8547 \
  -p 8548:8548 \
  offchainlabs/nitro-node:v2.0.10-73224e3 \
  --parent-chain.connection.url=${PARENT_CHAIN_URL} \
  --chain.id=${CHAIN_ID} \
  --http.api=net,web3,eth \
  --http.corsdomain=* \
  --http.addr=0.0.0.0 \
  --http.vhosts=* \
  --ws.port=8548 \
  --ws.addr=0.0.0.0 \
  --ws.origins=* \
  --init.url=${INIT_URL} \
  --init.prune=${INIT_PRUNE}"

# Run the Docker container
echo "Starting Arbitrum Nitro node..."
eval $DOCKER_CMD

# Logging
mkdir -p /root/arbitrum/log
echo "== Finished starting Arbitrum Nitro node =="

# Continuous logging
echo "=== Monitoring logs ==="
while true; do
  docker logs $(docker ps -q) >> /root/arbitrum/log/node.log
  sleep 5m
done
