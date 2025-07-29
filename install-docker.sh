#!/bin/bash

###############################################################################
# Script Name : install-docker.sh
# Description : A automated script to install Docker on Ubuntu
# Author      : Abid Ali
# Website     : https://abidali.site
# License     : MIT
# Usage       : https://raw.githubusercontent.com/itsSwArchitect/docker-installer/refs/heads/main/install-docker.sh | bash
###############################################################################

set -euo pipefail

#---------------------------#
# 1. Prerequisite Cleanup   #
#---------------------------#
echo "Removing older Docker packages if present..."
OLD_PKGS=(
  docker.io
  docker-doc
  docker-compose
  docker-compose-v2
  podman-docker
  containerd
  runc
)
for pkg in "${OLD_PKGS[@]}"; do
  sudo apt-get remove -y "$pkg" >/dev/null 2>&1 || true
done

#-----------------------------#
# 2. System Preparation       #
#-----------------------------#
echo "🔧 Updating package index and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

#--------------------------------------#
# 3. Add Docker’s Official GPG Key     #
#--------------------------------------#
echo "Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo tee /etc/apt/keyrings/docker.asc >/dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

#--------------------------------------#
# 4. Add Docker APT Repository         #
#--------------------------------------#
echo "Adding Docker APT repository..."
UBUNTU_CODENAME="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
ARCH="$(dpkg --print-architecture)"
echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${UBUNTU_CODENAME} stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

#------------------------------#
# 5. Install Docker Packages   #
#------------------------------#
echo "Updating package index and installing Docker..."
sudo apt-get update -y
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

#------------------------------#
# 6. Post-Installation Setup   #
#------------------------------#
echo "Adding current user ($USER) to the 'docker' group..."
sudo usermod -aG docker "$USER"

#------------------------------#
# 7. Post-Installation Checks  #
#------------------------------#
echo "Verifying Docker installation..."
docker --version
docker compose version

#------------------------------#
# 8. Final Instructions        #
#------------------------------#
cat << EOF

Docker installation completed successfully!

To use Docker as a non-root user, you must log out and back in.

OR run: newgrp docker

After that, try:
    docker run hello-world

⭐️ If you found this helpful, consider starring the repo:

    https://github.com/itsSwArchitect/docker-installer

EOF

