FROM ghcr.io/astral-sh/uv:python3.12-bookworm

# Default values for user and group
ARG USER_ID=1000
ARG USER_NAME=dev-user
ARG GROUP_ID=1000

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNNING_IN_DOCKER=true

RUN groupadd -g $GROUP_ID $USER_NAME && \
    useradd -m -u $USER_ID -g $GROUP_ID $USER_NAME -s /bin/bash

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg ca-certificates \
    curl \
    git

# Install Python project dependencies
COPY pyproject.toml ./
RUN uv pip install -r pyproject.toml --system

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Antora and its dependencies
RUN npm i -g antora@3.1.10
