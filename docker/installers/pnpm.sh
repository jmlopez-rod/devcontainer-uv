#!/bin/bash
set -xeuo pipefail

curl -fsSL https://get.pnpm.io/install.sh | env PNPM_VERSION=${PNPM_VERSION} SHELL="$(which bash)" bash -

# pnpm installation does not finish with a new line
echo '' >> /root/.bashrc

