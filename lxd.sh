#!/bin/bash
# Ensure the script exits if a command fails
set -e

# Change directory to the actions-runner directory in the home directory
cd actions-runner || exit
# Pull the latest changes from Git
git pull || exit

# Build the 'lxd' service quietly
docker compose build -q lxd || exit
# Start the 'lxd' service in detached mode using the prod-compose.yml file
docker compose -f prod-compose.yml up -d lxd || exit