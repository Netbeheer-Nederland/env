#!/bin/env bash

USER_ID=$(id -u) GROUP_ID=$(id -g) USER_NAME="$USER" docker compose run --remove-orphans nbnl-env
