#!/bin/bash
set -xeuo pipefail

docker tag devcontainer-uv ghcr.io/jmlopez-rod/devcontainer-uv:latest
docker push ghcr.io/jmlopez-rod/devcontainer-uv:latest
