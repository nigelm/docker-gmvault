#!/bin/sh

set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=nigelm
# image name
IMAGE=docker-gmvault
docker build -t $USERNAME/$IMAGE:latest .
