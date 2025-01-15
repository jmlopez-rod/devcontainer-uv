FROM ubuntu:latest
LABEL org.opencontainers.image.source="https://github.com/jmlopez-rod/devcontainer-uv"

ENV TZ=Etc/UTC
WORKDIR /scratch

## PATH setup
ENV UV_CACHE_DIR=/opt/uv/.cache/uv
ENV UV_LINK_MODE=symlink
ENV UV_BIN_DIR=/root/.cargo/bin
ENV UV_BIN_TOOLS=/root/.local/bin
ENV PATH=${UV_BIN_DIR}:${UV_BIN_TOOLS}:/root/.local/share/pnpm:${PATH}

## Base
RUN --mount=type=bind,source=docker/installers/apt-get.sh,target=./apt-get.sh \
  ./apt-get.sh

## Node and PNPM
ENV PNPM_VERSION=9.15.3
RUN --mount=type=bind,source=docker/installers/pnpm.sh,target=./pnpm.sh \
  ./pnpm.sh
RUN /bin/bash -i -c 'pnpm env use --global lts'

## uv and python
RUN --mount=type=bind,source=docker/installers/uv.sh,target=./uv.sh \
  ./uv.sh

## Taplo
RUN --mount=type=bind,source=docker/installers/taplo.sh,target=./taplo.sh \
  ./taplo.sh

## ohmybash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> /root/.bashrc
RUN echo "\n. /root/.bashrc.d/bash_aliases.sh" >> /root/.bashrc
RUN sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/' /root/.bashrc
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8


## Copy Scripts
COPY docker/bashrc.d /root/.bashrc.d

## Devcontainer info
ENV DK_CONTAINER_NAME='devcontainer'
ENV DK_CONTAINER_VERSION='uv_py311'
