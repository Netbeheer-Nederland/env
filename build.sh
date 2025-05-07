#!/bin/env bash

docker build \
    -t nbnl-env \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg USER_NAME="$USER" \
    --build-arg GIT_USER_NAME="$(git config --global user.name)" \
    --build-arg GIT_USER_EMAIL="$(git config --global user.email)" \
    .
