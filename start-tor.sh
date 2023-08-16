#!/usr/bin/env bash

echo "Using NICKNAME=${NICKNAME}, CONTACT_INFO=${CONTACT_INFO}, and OR_PORT=${OR_PORT}"

ACCOUNTING_MAX=$((MONTHLY_BANDWIDTH/31))
RELAY_BANDWIDTH_RATE=$((ACCOUNTING_MAX*20))
RELAY_BANDWIDTH_BURST=$((RELAY_BANDWIDTH_RATE*5))

cat > /etc/tor/torrc << EOF
RunAsDaemon 0

Nickname ${NICKNAME}
ContactInfo ${CONTACT_INFO}

ORPort ${OR_PORT}
SocksPort 0

ExitRelay 0

Log notice file /var/log/tor/log
Log notice stdout

DataDirectory /var/lib/tor

AccountingStart day 12:00
AccountingMax ${ACCOUNTING_MAX} GBytes
RelayBandwidthRate ${RELAY_BANDWIDTH_RATE} KBytes
RelayBandwidthBurst ${RELAY_BANDWIDTH_BURST} KBytes
EOF

echo "Starting Tor..."

tor -f /etc/tor/torrc