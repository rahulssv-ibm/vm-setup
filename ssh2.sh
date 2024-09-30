#!/bin/bash
# Ensure the script exits if a command fails
set -e

sudo snap install lxd
git clone https://github.com/rahulssv-ibm/gaplib.git
cd gaplib/build-files
cat lxd-preseed.yaml | lxd init --preseed
lxc storage set default volume.block.filesystem xfs

cd ..
./setup-build-env.sh -s 8
cd ..

git clone https://${GE_TOKEN}@github.ibm.com/ppc64le-automation/actions-runner.git