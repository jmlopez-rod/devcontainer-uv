#!/bin/bash
set -xeuo pipefail

export DOCKER_BUILDKIT=1

docker build --tag devcontainer-uv -f Dockerfile .
