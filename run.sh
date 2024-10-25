#!/bin/bash
# Ensure following creds
export DOCKER_USERNAME=Rahul.Vishwakarma2@ibm.com
# export DOCKER_PASSWORD=''
export img=na.artifactory.swg-devops.com/sys-linux-power-team-ftp3distro-docker-images-docker-local

set -e
chmod +x ssh1.sh
chmod +x ssh2.sh
./ssh1.sh
./ssh2.sh
