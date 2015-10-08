#
# Atlassian Bamboo Dockerfile
#

# Pull base image
FROM ubuntu:latest
MAINTAINER Said Sef <said@saidsef.co.uk>
ENV BB_PKG_NAME atlassian-bamboo-5.9.4
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH

# Install wget and OpenJDK7
RUN apt-get install -yq wget
RUN apt-get install -yq openjdk-7-jre

# Install Bamboo
RUN echo $BB_PKG_NAME
RUN wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz
RUN tar xvzf ${BB_PKG_NAME}.tar.gz
RUN rm -vf ${BB_PKG_NAME}.tar.gz
RUN mv /$BB_PKG_NAME /opt
RUN ls -lh /opt

# Define mountable directories
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/opt/$BB_PKG_NAME/bin/start-bamboo.sh"]

# Expose ports.
#   - 8085: HTTP
EXPOSE 8085