#!/bin/bash

# Stop the PostgreSQL service
sudo systemctl stop postgresql

# Get the PostgreSQL version
PG_VERSION=$(ls /etc/postgresql/)

# Edit the PostgreSQL configuration file to increase max_connections to 410 and shared_buffers to 1GB
sudo sed -E -i "s/^[# ]*max_connections[[:space:]]*=.*$/max_connections = 410/" /etc/postgresql/$PG_VERSION/main/postgresql.conf
sudo sed -E -i "s/^[# ]*shared_buffers[[:space:]]*=.*$/shared_buffers = 1GB/" /etc/postgresql/$PG_VERSION/main/postgresql.conf

# Start the PostgreSQL service
sudo systemctl start postgresql
