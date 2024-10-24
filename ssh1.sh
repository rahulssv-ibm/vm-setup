#!/bin/bash
# Ensure the script exits if a command fails
set -e

# installing snap
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
sudo dnf upgrade -y
sudo yum install snapd nano -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap