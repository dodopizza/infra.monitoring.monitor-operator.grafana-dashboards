# FLANT SHELL-OPERATOR - https://github.com/flant/shell-operator/blob/main/Dockerfile
FROM ghcr.io/flant/shell-operator:v1.4.11 AS shelloperator

#
FROM ubuntu:jammy

# Must be amd64 or arm64
ARG TARGETARCH

# JQ FROM FLANT
COPY --from=shelloperator /usr/bin/jq /usr/bin

# SHELL-OPERATOR FROM FLANT
COPY --from=shelloperator /shell-operator /usr/bin

# JSONNET - https://github.com/dodopizza/google-jsonnet
RUN curl -sL https://dodopizza.github.io/google-jsonnet/dl.sh | bash

# KUBECTL
RUN cd /tmp && \
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" && \
  chmod +x kubectl && mv kubectl /usr/local/bin/

# HELM - https://github.com/helm/helm
RUN cd /tmp && \
  version=3.16.1 && \
  curl -L https://get.helm.sh/helm-v${version}-linux-${TARGETARCH}.tar.gz | tar xz && \
  mv linux-${TARGETARCH}/helm /usr/local/bin/helm
