#!/bin/bash
# Ensure the script exits if a command fails
set -e

# installing snap
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf upgrade
sudo yum install snapd nano
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap