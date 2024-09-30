#!/bin/bash
# Ensure the script exits if a command fails
set -e
chmod +x ssh1.sh
chmod +x ssh2.sh
./ssh1.sh
./ssh2.sh
