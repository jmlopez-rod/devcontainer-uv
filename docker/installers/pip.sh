#!/bin/bash
set -xeuo pipefail

mkdir -p \
  /opt/pnpm \
  /opt/venv \
  /root/.vscode-server/extensions \
  /root/.vscode-server-insiders/extensions \
  /__w

pip install jmlopez-m==${M_VERSION} poetry==${POETRY_VERSION}
