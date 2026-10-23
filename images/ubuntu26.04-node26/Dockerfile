# Imagem base ATUAL: Ubuntu 26.04 LTS + Node.js 26 (LTS a partir de 28/10/2026)
# Para trocar a versão do Node sem editar o arquivo:
#   docker build --build-arg NODE_MAJOR=24 .
FROM ubuntu:26.04

ARG NODE_MAJOR=26
ARG DEBIAN_FRONTEND=noninteractive

LABEL org.opencontainers.image.description="Base Ubuntu 26.04 + Node.js ${NODE_MAJOR}"

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl gnupg ca-certificates build-essential git python3 locales && \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - && \
    apt-get -y install nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configura locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

WORKDIR /base

# Falha o build se a versão instalada não for a esperada
RUN node -v && npm -v && \
    node -e "process.exit(process.versions.node.split('.')[0] === '${NODE_MAJOR}' ? 0 : 1)"
