# MICROSOFT
FROM mcr.microsoft.com/devcontainers/base:jammy

# Must be amd64 or arm64
ARG TARGETARCH

# BASE
RUN apt install -y make unzip

# JSONNET - https://github.com/dodopizza/google-jsonnet
RUN curl -sL https://dodopizza.github.io/google-jsonnet/dl.sh | bash

# YQ - https://github.com/mikefarah/yq
RUN cd /tmp && \
  version=4.45.1 && \
  curl -L --output /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v${version}/yq_linux_${TARGETARCH} && \
  chmod +x /usr/local/bin/yq

# DOCKER-CLI - https://download.docker.com/linux/static/stable/
RUN cd /tmp && \
  version=28.0.1 && \
  arch=${TARGETARCH} && \
  [ "$arch" = "arm64" ] && arch="aarch64"; \
  [ "$arch" = "amd64" ] && arch="x86_64"; \
  curl -L https://download.docker.com/linux/static/stable/${arch}/docker-${version}.tgz | tar xz && \
  mv docker/docker /usr/local/bin/

# HELM - https://github.com/helm/helm
RUN cd /tmp && \
  version=3.17.2 && \
  curl -L https://get.helm.sh/helm-v${version}-linux-${TARGETARCH}.tar.gz | tar xz && \
  mv linux-${TARGETARCH}/helm /usr/local/bin/helm
