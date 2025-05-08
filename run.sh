#!/bin/env bash

SCRIPT_DIR=$(dirname "$0")
LOCAL_PROJECT_DIR="${1:-.}"
USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER_NAME="$USER"
GIT_USER_NAME="$(git config --global user.name)"
GIT_USER_EMAIL="$(git config --global user.email)"

docker run \
    -it \
    --user "$USER_ID:$GROUP_ID" \
    -v "$LOCAL_PROJECT_DIR":/project \
    -v "$HOME/.ssh:$HOME/.ssh" \
    -v "$SCRIPT_DIR/entrypoint.sh":/usr/local/bin/entrypoint.sh \
    -e GIT_USER_EMAIL="$GIT_USER_EMAIL" \
    -e GIT_USER_NAME="$GIT_USER_NAME" \
    --entrypoint /usr/local/bin/entrypoint.sh \
    -w /project \
    -p 8080:8080 \
    bartkl/nbnl-env:latest \
    /bin/bash
