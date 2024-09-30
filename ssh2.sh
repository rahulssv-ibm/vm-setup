#!/bin/bash
# Ensure the script exits if a command fails
set -e

sudo snap install lxd
PATH=/snap/bin/:$PATH
git clone https://github.com/rahulssv-ibm/gaplib.git
cd gaplib/build-files
cat lxd-preseed.yaml | lxd init --preseed
lxc storage set default volume.block.filesystem xfs
lxc network set lxdbr0 ipv6.firewall false
lxc network set lxdbr0 ipv4.firewall false
sudo systemctl reload snap.lxd.daemon

cd ..
./setup-build-env.sh -s 8
cd ..

git clone https://${GE_TOKEN}@github.ibm.com/ppc64le-automation/actions-runner.git
# setup lxd
# Change directory to the actions-runner directory in the home directory
cd actions-runner
git checkout sso-flow 
# Pull the latest changes from Git
git pull 

# Build the 'lxd' service quietly
sudo systemctl restart docker.socket
# docker compose build -q lxd 
docker compose build lxd 
# Start the 'lxd' service in detached mode using the prod-compose.yml file
docker compose -f prod-compose.yml up -d lxd 