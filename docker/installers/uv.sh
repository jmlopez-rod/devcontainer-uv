#!/bin/bash
set -xeuo pipefail

mkdir -p \
  /opt/pnpm \
  /opt/venv \
  /root/.vscode-server/extensions \
  /__w

curl -LsSf https://astral.sh/uv/install.sh | sh

uv python install 3.11
