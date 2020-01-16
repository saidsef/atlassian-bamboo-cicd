#!/bin/sh

# Copyright (c) 2018, Said Sef. All rights reserved.
# Use of this source code is governed by a MIT License that can be

set -e

BUILD_ID=$1
REF=`git rev-parse --short HEAD`

info() {
  echo """
    This is a containerised Bamboo application
  """
}

cleanup() {
  echo "Remove dorment containers"
  if [ ! -z "$(docker ps -a -q | head -n 1)" ]; then
    docker stop $(docker ps -a -q)
    docker rm -f $(docker ps -a -q)
  else
    echo "There is no dorment containers"
  fi
}

delete() {
  echo "Remove dorment images"
  if [ ! -z "$(docker images -a -q | head -n 1)" ]; then
    docker rmi -f $(docker images -a -q) || true
  else
    echo "There are no dorment images"
  fi
}

# deprecated in favour of buildx
# build() {
#   echo "Building image"
#   docker build --build-arg "BUILD_ID=${BUILD_ID}" --build-arg "REF=${REF}" -t saidsef/ubuntu-bamboo-dockerfile .
#   docker build --build-arg "BUILD_ID=${BUILD_ID}" --build-arg "REF=${REF}" -t saidsef/ubuntu-bamboo-dockerfile:arm64 . -f Dockerfile.arm64
#   docker tag saidsef/ubuntu-bamboo-dockerfile saidsef/ubuntu-bamboo-dockerfile:0.${BUILD_ID}
# }

buildx() {
  echo "Build multi ARCH"
  docker buildx create --use
  docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t saidsef/ubuntu-bamboo-dockerfile:latest --push .
}

# deprecated in favour of buildx
# push() {
#   echo "Pushing image to docker hub"
#   docker push saidsef/ubuntu-bamboo-dockerfile
#   echo $?
# }

main() {
  info
  cleanup
  buildx
  # build
  # push
  # cleanup
  # delete
}

main
