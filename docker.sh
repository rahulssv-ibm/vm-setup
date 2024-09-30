#!/bin/bash
# Ensure the script exits if a command fails
set -e
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo docker --version