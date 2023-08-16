[![ci](https://github.com/irisdotsh/tor-middle-guard-relay/actions/workflows/ci.yml/badge.svg)](https://github.com/irisdotsh/tor-middle-guard-relay/actions/workflows/ci.yml)

# Tor Middle/Guard Relay

Docker files to run a Tor middle/guard relay.

# Deploying a Container

Create a [docker-compose.yml](https://github.com/irisdotsh/tor-middle-guard-relay/blob/main/docker-compose.yml) file to pull the package from Docker Hub or the GitHub Container Registry.

Make sure the following env variables are set:
- NICKNAME (relay nickname)
- CONTACT_INFO (relay owner's email)
- OR_PORT (relay port)

The example [docker-compose.yml](https://github.com/irisdotsh/tor-middle-guard-relay/blob/main/docker-compose.yml) file looks for a .env file with these variables set.

Deploy the container: `docker-compose up -d tor-middle-guard-relay`

**NOTE**: Make sure your firewall allows inbound and outbound tcp traffic to and from the OR_PORT.

# Upgrading a Container

Upgrading a container is extremely simple.  You only need to use two commands.

Pull the latest image: `docker-compose pull tor-middle-guard-relay`

Deploy the container: `docker-compose up -d tor-middle-guard-relay`

# Monitoring Relay Logs

You only need a single command to monitor your relay's logs.

`docker logs CONTAINER_ID`