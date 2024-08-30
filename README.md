# Ethereum RPC Node Deployment on Akash Network

This repository contains the necessary configuration files to deploy an Ethereum RPC node on the Akash Network using the official `ethereum/client-go` Docker image. The node is configured to expose both the Ethereum P2P and JSON-RPC endpoints, making it accessible globally.

## Deployment Overview

The deployment uses the following resources:
- **CPU:** 4 units
- **Memory:** 16 GiB
- **Storage:** 700 GiB

### Exposed Ports
- **30303:** Ethereum P2P port (used for peer communication).
- **8545:** JSON-RPC HTTP port (used for RPC API access).
