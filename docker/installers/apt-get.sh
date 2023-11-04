#!/bin/bash
set -xeuo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y git curl
rm -rf /var/cache/apt/archives /var/lib/apt/lists
