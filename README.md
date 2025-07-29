# Docker Installer for Ubuntu

A production-ready Bash script to install Docker Engine, Docker Compose, and containerd on **Ubuntu** systems.  
This script ensures a clean setup, handles old package cleanup, adds official Docker repos, and sets up non-root Docker usage.

---

## Features

✅ Removes conflicting old Docker packages  
✅ Installs Docker CE, CLI, containerd, Buildx, and Compose Plugin  
✅ Adds Docker GPG key and APT repository  
✅ Adds current user to the `docker` group  
✅ Supports `newgrp` for immediate group update  
✅ One-liner install via `curl` or `wget`  
✅ Tested on Ubuntu 20.04 and 22.04+

---

## Installation

### One-liner (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/itsSwArchitect/docker-installer/main/install-docker.sh | bash
