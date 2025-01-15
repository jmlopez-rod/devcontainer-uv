#!/bin/bash
set -xeuo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y git curl make bash-completion
rm -rf /var/cache/apt/archives /var/lib/apt/lists
