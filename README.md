# Atlassian Bamboo CI Dockerfile [![CI](https://github.com/saidsef/atlassian-bamboo-cicd/actions/workflows/docker.yml/badge.svg)](#prerequisites) [![Tagging](https://github.com/saidsef/atlassian-bamboo-cicd/actions/workflows/tagging.yml/badge.svg)](#prerequisites) [![Release](https://github.com/saidsef/atlassian-bamboo-cicd/actions/workflows/release.yml/badge.svg)](#prerequisites)

This repository contains **Dockerfile** of [Bamboo](https://www.atlassian.com/software/bamboo/download) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image

* [openjdk:jre-alpine](https://hub.docker.com/_/openjdk/)

## Prerequisites

1. [Docker](https://www.docker.com/)
2. Download from [Docker Hub Registry](https://hub.docker.com/r/saidsef/atlassian-bamboo-cicd): `docker pull docker.io/saidsef/atlassian-bamboo-cicd`
3. [Atlasian Bamboo License](https://my.atlassian.com/license/evaluation)

> Read Administration and Configuration of [Bamboo Server](https://confluence.atlassian.com/bamboo0702/administering-bamboo-1031179795.html) documantation

## Usage

```shell
docker run -d -p 8085:8085 $PWD:/data docker.io/saidsef/atlassian-bamboo-cicd:latest
```

### Attach persistent/shared directories

1. Create a mountable data directory `<data-dir>` on the host.
2. Start a container by mounting data directory and specifying the custom configuration file:

```shell
docker run -d -p 8085:8085 -v <data-dir>:/data saidsef/atlassian-bamboo-cicd /opt/path-to-app/bin/start-bamboo.sh
```

> After few seconds, open `http://localhost:8085`

### Kubernetes Deployment

```shell
kubectl apply -k deployment/
```

> you might need to use `kubectl port-forward svc/bamboo 8085

Then, open `http://localhost:8085` to see the result.

## Docs

```shell
mkdocs build
mkdocs serve
```

Open up `http://127.0.0.1:8000/` in your browser, and you'll see the default home page being displayed

## Source

Our latest and greatest source of Jenkins can be found on [GitHub](#usage). Fork us!

## Contributing

We would :heart:  you to contribute by making a [pull request](https://github.com/saidsef/atlassian-bamboo-cicd/pulls).

Please read the official [Contribution Guide](./CONTRIBUTING.md) for more information on how you can contribute.
