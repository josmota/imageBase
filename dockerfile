# Imagem base: Ubuntu 22.04 + Node.js 20 + dependências comuns
FROM ubuntu:22.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl gnupg build-essential git python3 locales && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get -y install nodejs && \
    rm -rf /var/lib/apt/lists/*

# Configura locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

WORKDIR /base

# Exibe versões para debug
RUN node -v && npm -v
