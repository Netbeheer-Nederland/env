#!/bin/env bash

SCRIPT_DIR=$(dirname "$0")

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER_NAME="$USER"
GIT_USER_NAME="$(git config --global user.name)"
GIT_USER_EMAIL="$(git config --global user.email)"

docker run \
    -it \
    --user "$USER_ID:$GROUP_ID" \
    -v .:/project \
    -v "$HOME:$HOME" \
    -v "$SCRIPT_DIR/entrypoint.sh":/entrypoint.sh \
    -e GIT_USER_EMAIL="$GIT_USER_EMAIL" \
    -e GIT_USER_NAME="$GIT_USER_NAME" \
    --entrypoint /entrypoint.sh \
    bartkl/nbnl-env \
    /bin/bash
