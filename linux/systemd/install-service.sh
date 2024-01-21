#!/usr/bin/env bash

# Installs a service as part of systemd
# Usage: ./install-service.sh linux-service-configuration
# Example: ./install-service.sh target-linux-service.service

if [ "$1" = "" ];
then
    echo "The service configuration is expected as \$1"
    exit 1
fi

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SERVICE_CFG="$1"
SERVICE_NAME="$(basename $SERVICE_CFG)"

sudo cp "$SERVICE_CFG" "/etc/systemd/system/$SERVICE_NAME"

sudo systemctl daemon-reload

sudo systemctl enable "$SERVICE_NAME"

sudo systemctl start "$SERVICE_NAME"

sudo systemctl status "$SERVICE_NAME"
