#
# Atlassian Bamboo Dockerfile
#

# Pull base image Ubuntu 16.04 LTS
FROM ubuntu:16.04
MAINTAINER Said Sef <said@saidsef.co.uk>
ENV BB_PKG_NAME atlassian-bamboo-5.13.0.1
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH

# Update OS
RUN apt-get -yq update

# Install wget and OpenJDK 8
RUN apt-get install -yq wget openjdk-8-jre-headless

# Clean up APT cache
RUN apt-get clean && \
    apt-get autoclean

# Install Bamboo
RUN echo $BB_PKG_NAME
RUN wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz
RUN tar xvzf ${BB_PKG_NAME}.tar.gz
RUN rm -vf ${BB_PKG_NAME}.tar.gz
RUN mv $BB_PKG_NAME /opt
RUN ls -lh /opt

# Define mountable directories
VOLUME ["/data"]

# ADD  bamboo-init.properties config
ADD config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 8085: HTTP
EXPOSE 8085

# Define default command.
CMD ["/opt/$BB_PKG_NAME/bin/start.sh"]
