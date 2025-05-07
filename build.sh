#!/bin/env bash

docker build -t nbnl-env --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --build-arg USER_NAME="$USER" .
