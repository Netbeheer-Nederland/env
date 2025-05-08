FROM ghcr.io/astral-sh/uv:python3.12-bookworm

#EXPOSE 8080

ARG GIT_USER_NAME
ARG GIT_USER_EMAIL
ARG USER_ID=1000
ARG USER_NAME=dev-user
ARG GROUP_ID=1000

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

ENV RUNNING_IN_DOCKER=true
ENV NODE_PATH=/usr/lib/node_modules


RUN groupadd -g $GROUP_ID $USER_NAME && \
    useradd -m -u $USER_ID -g $GROUP_ID $USER_NAME -s /bin/bash

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg ca-certificates \
    curl \
    git \
    nano \
    vim

# Install Python project dependencies
COPY requirements.txt /tmp
RUN uv pip install -r /tmp/requirements.txt --system

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Antora and its dependencies
#RUN npm i -g corepack

#RUN yarn global add --ignore-optional --silent \
RUN npm i -g \
    http-serve@1.0.1 \
    @antora/cli@3.1.9 \
    @antora/lunr-extension@^1.0.0-alpha.8 \
    @antora/site-generator@3.1.9 \
    @mermaid-js/mermaid-cli@^11.4.2 \
    asciidoctor-kroki@^0.18.1 \
    @djencks/asciidoctor-mathjax@^0.0.9

# Install shell completions for just
RUN just --completions bash >> /usr/share/bash-completion/completions/just \
    && echo "source /usr/share/bash-completion/completions/just" >> /etc/bash.bashrc
