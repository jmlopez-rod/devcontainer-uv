#!/bin/bash
set -xeuo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y make bash-completion
rm -rf /var/cache/apt/archives /var/lib/apt/lists

register-python-argcomplete --shell bash m >/usr/share/bash-completion/completions/m
