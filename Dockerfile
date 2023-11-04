FROM python:3.11.3-slim-bullseye
LABEL org.opencontainers.image.source="https://github.com/jmlopez-rod/devcontainer-python"

WORKDIR /scratch

# PIP
ENV M_VERSION=0.29.4
ENV POETRY_VERSION=1.6.1
RUN --mount=type=bind,source=docker/installers/pip.sh,target=./pip.sh ./pip.sh

# APT-GET
RUN --mount=type=bind,source=docker/installers/apt-get.sh,target=./apt-get.sh ./apt-get.sh

# PNPM
ENV PNPM_VERSION=8.10.2
ENV NODE_VERSION=20.6.1
RUN --mount=type=bind,source=docker/installers/pnpm.sh,target=./pnpm.sh ./pnpm.sh

## Poetry Settings
ENV POETRY_HOME=/opt/venv/poetry
ENV POETRY_CACHE_DIR=/opt/venv/.cache/pypoetry

# APT-GET
RUN --mount=type=bind,source=docker/installers/dev-utils.sh,target=./dev-utils.sh ./dev-utils.sh

# COPY SCRIPTS
COPY docker/bashrc.d /root/.bashrc.d
COPY docker/m_helpers /opt/m_helpers

## PATH setup
ENV PATH=/root/.local/share/pnpm:${PATH}
RUN echo "\n. /root/.bashrc.d/bash_aliases.sh" >>/root/.bashrc

## Devcontainer info
ENV DK_CONTAINER_NAME='devcontainer'
ENV DK_CONTAINER_VERSION='3.11.3'
