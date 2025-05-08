#!/bin/env bash

LOCAL_PROJECT_DIR="${1:-$PWD}"
PROJECT_DIR=/project/$(basename "$LOCAL_PROJECT_DIR")
USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER_NAME="$USER"

GIT_FOUND=$(command -v git)

# Git user name
if [ -z "$GIT_USER_NAME" ] && [ -n "$GIT_FOUND" ]; then
    git_user_name="$(git config user.name)"
    if [ -n "$git_user_name" ]; then
        GIT_USER_NAME="$git_user_name"
    else
        echo "Git user name could not be set."; exit 1
    fi
fi

# Git user e-mail
if [ -z "$GIT_USER_EMAIL" ] && [ -n "$GIT_FOUND" ]; then
    git_user_email="$(git config user.email)"
    if [ -n "$git_user_email" ]; then
        GIT_USER_EMAIL="$git_user_email"
    else
        echo "Git user e-mail could not be set."; exit 1
    fi
fi

docker run \
    -it \
    --user "$USER_ID:$GROUP_ID" \
    -v "$LOCAL_PROJECT_DIR":"$PROJECT_DIR" \
    -v "$HOME/.ssh:$HOME/.ssh" \
    -e GIT_USER_EMAIL="$GIT_USER_EMAIL" \
    -e GIT_USER_NAME="$GIT_USER_NAME" \
    -w "$PROJECT_DIR" \
    -p 8080:8080 \
    bartkl/nbnl-env:latest \
    /bin/bash
