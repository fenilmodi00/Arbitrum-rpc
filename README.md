# Tezos Node Deployment with Docker and Akash

This README provides instructions for deploying a Tezos node using Docker, as well as running it on the Akash decentralized cloud platform. The guide is split into two main sections: setting up the node using Docker on a local machine, and deploying the node on Akash.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Docker Setup](#docker-setup)
  - [Step 1: Install Docker](#step-1-install-docker)
  - [Step 2: Configure and Run the Tezos Node](#step-2-configure-and-run-the-tezos-node)
  - [Useful Commands](#useful-commands)
- [Akash Deployment](#akash-deployment)
  - [Docker Compose File](#docker-compose-file)
  - [Profiles](#profiles)
  - [Deployment](#deployment)
- [References](#references)

## Prerequisites
- A Linux-based operating system.
- Basic understanding of Docker and blockchain concepts.
- Akash CLI installed and configured on your machine.

## Docker Setup

### Step 1: Install Docker
If Docker is not already installed on your machine, you can install it by running the following command:

```bash
sudo apt install docker.io
```

After installation, follow the post-installation instructions to manage Docker as a non-root user [here](https://docs.docker.com/engine/install/linux-postinstall/).

### Step 2: Configure and Run the Tezos Node
Run the Tezos node in detached mode (`-d`) on the ParisCnet testnet with the history mode set to "full." Use the following command:

```bash
docker run --name=octez-public-node-full \
  -v node-data-volume:/var/run/tezos/node \
  tezos/tezos:latest octez-node --network=parisCnet
```

This command does the following:
- Pulls the `tezos/tezos:latest` Docker image.
- Mounts `node-data-volume` to store blockchain data.
- Configures the node to use the `parisCnet` testnet.
- Sets the history mode to "full" which retains all block headers and operations.

After a few minutes, the node identity will be generated. You can check if the node is bootstrapped using:

```bash
docker exec -it octez-public-node-full octez-client --endpoint http://127.0.0.1:8732 bootstrapped
```

Press `Ctrl+C` to stop logs from displaying.

### Useful Commands
Here are some useful Docker commands for managing the Tezos node:

- **View the Tezos node manual**:
  ```bash
  docker run -it tezos/tezos:latest man
  ```

- **See available commands and options**:
  ```bash
  docker run -it tezos/tezos:latest octez-node --help
  ```

- **Use the Tezos client**:
  ```bash
  docker exec -it octez-public-node-full octez-client --help
  ```

- **Check the logs**:
  ```bash
  docker logs octez-public-node-full
  ```

## Akash Deployment

### Docker Compose File
The following is a `docker-compose.yml` file for deploying a Tezos node on the Akash network:



## References
- [Tezos Docker Hub](https://hub.docker.com/r/tezos/tezos)
- [Tezos Node Documentation](https://tezos.gitlab.io/shell/)
- [Akash Deployment Documentation](https://docs.akash.network/)

This guide should help you set up and deploy a Tezos node both locally using Docker and on the Akash decentralized cloud. For further customization and more advanced configurations, refer to the official documentation linked in the references.
