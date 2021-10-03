# Atlassian Bamboo CI Dockerfile [![Build Status](https://travis-ci.org/saidsef/ubuntu-bamboo-dockerfile.svg?branch=master)](https://travis-ci.org/saidsef/ubuntu-bamboo-dockerfile)

This repository contains **Dockerfile** of [Bamboo](https://www.atlassian.com/software/bamboo/download) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image

* [java:jre-alpine](https://hub.docker.com/_/java/)

## Prerequisites

1. [Docker](https://www.docker.com/).
2. Download from [Docker Hub Registry](https://hub.docker.com/r/saidsef/ubuntu-bamboo-dockerfile): `docker pull docker.io/saidsef/ubuntu-bamboo-dockerfile`
3. [Atlasian Bamboo License](https://my.atlassian.com/)

## Usage

```shell
docker run -d -p 8085:8085 $PWD:/data saidsef/ubuntu-bamboo-dockerfile
```

### Attach persistent/shared directories

1. Create a mountable data directory `<data-dir>` on the host.
2. Start a container by mounting data directory and specifying the custom configuration file:

```shell
docker run -d -p 8085:8085 -v <data-dir>:/data saidsef/ubuntu-bamboo-dockerfile /opt/path-to-app/bin/start-bamboo.sh
```

After few seconds, open `http://<host>:8085` to see the result.

### Kubernetes Deployment

> Create Kubernets namespace `cicd` i.e. `kubectl create namespace cicd`

```shell
kubectl apply -k deployment/
```

> you might need to use `kubectl port-forward ...`
After few seconds, open `http://bamboo.[namespace].svc:8085` to see the result.

## Docs

```shell
mkdocs build
mkdocs serve
```

Open up `http://127.0.0.1:8000/` in your browser, and you'll see the default home page being displayed

## Source

Our latest and greatest source of Jenkins can be found on [GitHub](#usage). Fork us!

## Contributing

We would :heart:  you to contribute by making a [pull request](https://github.com/saidsef/ubuntu-bamboo-dockerfile/pulls).

Please read the official [Contribution Guide](./CONTRIBUTING.md) for more information on how you can contribute.
