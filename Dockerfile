#
# Atlassian Bamboo Dockerfile
#

# Pull base image Ubuntu 16.04 LTS
FROM ubuntu:latest
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL version="2.0"
LABEL description="Containerised Bomboo Server"

ENV BB_PKG_NAME atlassian-bamboo-5.13.2
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp

# Define working directory.
WORKDIR /data

# Update OS
RUN apt-get -yq update

# Install wget and OpenJDK 8
RUN apt-get install -yq wget curl openjdk-8-jre-headless

# Clean up APT cache
RUN apt-get clean && \
    apt-get autoclean

# Install Bamboo
RUN echo $BB_PKG_NAME
RUN wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz
RUN tar xvzf ${BB_PKG_NAME}.tar.gz
RUN rm -vf ${BB_PKG_NAME}.tar.gz
RUN mv $BB_PKG_NAME /opt

# Define mountable directories
VOLUME ["/data"]

# ADD  bamboo-init.properties config
ADD config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

# Expose ports.
#   - 8085: HTTP
EXPOSE 8085

# Define default command.
CMD ["/opt/$BB_PKG_NAME/bin/start.sh"]
