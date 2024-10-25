#!/bin/bash
# Ensure the script exits if a command fails
set -e
sudo snap install lxd
export PATH=/snap/bin/:$PATH
git clone https://github.com/rahulssv-ibm/gaplib.git
cd gaplib/build-files
cat lxd-preseed.yaml | lxd init --preseed
lxc storage set default volume.block.filesystem xfs
echo "net.ipv4.conf.all.forwarding=1" > /etc/sysctl.d/99-forwarding.conf # Prevent connectivity issues with LXD and Docker
systemctl restart systemd-sysctl
# for ipt in iptables ip6tables; do $ipt --flush; $ipt --flush -t nat; $ipt --flush -t mangle; $ipt --delete-chain; $ipt --delete-chain -t nat; $ipt -P FORWARD ACCEPT; $ipt -P INPUT ACCEPT; $ipt -P OUTPUT ACCEPT; done
# lxc network set lxdbr0 ipv6.firewall false
# lxc network set lxdbr0 ipv4.firewall false
# sudo systemctl reload snap.lxd.daemon
# sleep 10
cd ..
./setup-build-env.sh -s 8
cd ..
cd ..
# sudo dnf -y install podman
# echo "${PODMAN_PASSWORD}" | podman login $img -u "${PODMAN_USERNAME}" --password-stdin
# podman run --name lxd-app -d  -v /var/snap/lxd/common/lxd/unix.socket:/var/snap/lxd/common/lxd/unix.socket --env-file env.prod.example $img/lxd-app

# setup docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo docker --version

export GATEWAY_IP=$(ip r| grep "/24 via" | awk '{print $3}')
sudo ip route add 166.9.52.42 via $GATEWAY_IP  # Add route for private redis endpoint

echo "${DOCKER_PASSWORD}" | docker login $img -u "${DOCKER_USERNAME}" --password-stdin
docker run --name lxd-app -d  -v /var/snap/lxd/common/lxd/unix.socket:/var/snap/lxd/common/lxd/unix.socket --env-file env.prod.example $img/lxd-app

# git clone https://${GE_TOKEN}@github.ibm.com/ppc64le-automation/actions-runner.git
# setup lxd
# Change directory to the actions-runner directory in the home directory
# cd actions-runner
# git checkout sso-flow 
# Pull the latest changes from Git
# git pull 

# Build the 'lxd' service quietly
# sudo systemctl restart docker.socket
# docker compose build -q lxd 
# docker compose build lxd 
# Start the 'lxd' service in detached mode using the prod-compose.yml file
# docker compose -f prod-compose.yml up -d lxd 