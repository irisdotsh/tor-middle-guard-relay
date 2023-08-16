[![ci](https://github.com/irisdotsh/tor-middle-guard-relay/actions/workflows/ci.yml/badge.svg)](https://github.com/irisdotsh/tor-middle-guard-relay/actions/workflows/ci.yml)

# Tor Middle/Guard Relay

Docker files to run a Tor middle/guard relay.

# Deploying a Container

Create a [docker-compose.yml](https://github.com/irisdotsh/tor-middle-guard-relay/blob/main/docker-compose.yml) file to pull the package from Docker Hub or the GitHub Container Registry.

Make sure the following env variables are set:
- NICKNAME (relay nickname)
- CONTACT_INFO (relay owner's email)
- OR_PORT (relay port)
- BANDWIDTH_LIMIT (monthly bandwidth limit in GB)

The example [docker-compose.yml](https://github.com/irisdotsh/tor-middle-guard-relay/blob/main/docker-compose.yml) file looks for a .env file with these variables set.

Deploy the container: `docker compose up -d tor-middle-guard-relay`

**NOTE**: Make sure your firewall allows inbound and outbound tcp traffic to and from the OR_PORT.

# Upgrading a Container

Upgrading a container is extremely simple.  You only need to use two commands.

Pull the latest image: `docker compose pull tor-middle-guard-relay`

Deploy the container: `docker compose up -d tor-middle-guard-relay`

# Monitoring Relay Logs

You only need a single command to monitor your relay's logs.

`docker logs CONTAINER_ID`

# Verifying Image Signature

All images pushed to Docker Hub and the GitHub Container Registry are signed via cosign with my [cosign key](https://irisblankenship.blog/_/cosign.pub).

You can verify them via cosign with the following commands:

`cosign verify --key https://irisblankenship.blog/_/cosign.pub irisdotsh/tor-middle-guard-relay:latest`

`cosign verify --key https://irisblankenship.blog/_/cosign.pub ghcr.io/irisdotsh/tor-middle-guard-relay:latest`

The public key is stored in the repo as well.