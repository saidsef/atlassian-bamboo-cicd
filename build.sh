#!/bin/sh

BUILD_ID=$1

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
    echo "There is no dorment images"
  fi
}

build() {
  echo "Building image"
  docker build --build-arg "BUILD_ID=${BUILD_ID}" -t saidsef/ubuntu-bamboo-dockerfile .
  docker tag saidsef/ubuntu-bamboo-dockerfile saidsef/ubuntu-bamboo-dockerfile:build-${BUILD_ID}
}

push() {
  echo "Pushing image to docker hub"
  docker push saidsef/ubuntu-bamboo-dockerfile
  echo $?
}

main() {
  info
  cleanup
  build
  push
  cleanup
  delete
}

main
