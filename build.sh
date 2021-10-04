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

build() {
  echo "Building container"
  docker build -t docker.io/saidsef/ubuntu-bamboo-dockerfile:${BUILD_ID} .
  docker push docker.io/saidsef/ubuntu-bamboo-dockerfile:${BUILD_ID}
}

main() {
  info
  cleanup
  build
}

main
