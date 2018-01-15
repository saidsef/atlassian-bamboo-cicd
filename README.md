# Atlassian Bamboo CI Dockerfile [![Build Status](https://travis-ci.org/saidsef/ubuntu-bamboo-dockerfile.svg?branch=master)](https://travis-ci.org/saidsef/ubuntu-bamboo-dockerfile)

This repository contains **Dockerfile** of [Bamboo](https://www.atlassian.com/software/bamboo/download) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image
* [java:jre-alpine](https://hub.docker.com/_/java/)


## Installation
1. Install [Docker](https://www.docker.com/).
2. Download [automated build](https://registry.hub.docker.com/u/dockerfile/elasticsearch/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull saidsef/ubuntu-bamboo-dockerfile`

## Usage

```shell
docker run -d -p 8085:8085 saidsef/ubuntu-bamboo-dockerfile
```

### Attach persistent/shared directories
  1. Create a mountable data directory `<data-dir>` on the host.
  2. Start a container by mounting data directory and specifying the custom configuration file:

```shell
docker run -d -p 8085:8085 -v <data-dir>:/data saidsef/ubuntu-bamboo-dockerfile /opt/path-to-app/bin/start-bamboo.sh
```

After few seconds, open `http://<host>:8085` to see the result.
