# Pull debian stable slim image
FROM debian:stable-slim

# Metadata
LABEL org.opencontainers.image.authors="Iris Blankenship"
LABEL org.opencontainers.image.source="https://github.com/irisdotsh/tor-middle-guard-relay"
LABEL org.opencontainers.image.documentation="https://github.com/irisdotsh/tor-middle-guard-relay"
LABEL org.opencontainers.image.title="tor-middle-guard-relay"
LABEL org.opencontainers.image.description="tor middle/guard relay on debian slim"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.version="0.0.1"

# Install prerequisites
RUN apt-get update && \
    apt-get install -y \
    curl \
    gpg \
    lsb-release

# Add the signing key to /usr/share/keyrings
RUN curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg -o /usr/share/keyrings/tor-keyring.pgp --dearmor && \
    echo "deb [signed-by=/usr/share/keyrings/tor-keyring.pgp] https://deb.torproject.org/torproject.org $(lsb_release -cs) main" > /etc/apt/sources.list.d/tor.list

# Install tor
RUN apt-get update && \
    apt-get install -y \
    tor

# Remove default torrc
RUN rm /etc/tor/torrc

# Give ownership of /etc/tor and /var/log/tor to debian-tor
RUN chown debian-tor:debian-tor /etc/tor /var/log/tor

# Copy start-tor.sh to /usr/local/bin and make it executable
COPY ./start-tor.sh /usr/local/bin/
RUN chmod 0755 /usr/local/bin/start-tor.sh

# Switch to debian-tor user
USER debian-tor

# Set cmd to start-tor.sh
CMD ["/usr/local/bin/start-tor.sh"]