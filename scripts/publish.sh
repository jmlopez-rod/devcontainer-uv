#!/bin/bash
set -xeuo pipefail

docker tag devcontainer-python ghcr.io/jmlopez-rod/devcontainer-python:latest
docker push ghcr.io/jmlopez-rod/devcontainer-python:latest
