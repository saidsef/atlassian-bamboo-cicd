FROM java:8-jre-alpine
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL version="4.0"
LABEL description="Containerised Bomboo Server"

# bamboo version
ARG BAMBOO_VERSION=""

ENV BB_PKG_NAME atlassian-bamboo-${BAMBOO_VERSION:-6.2.2}
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp

# Define working directory.
WORKDIR /data

# Install wget
RUN apk add --update wget

# Download Install Bamboo
RUN echo $BB_PKG_NAME
RUN wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz
RUN tar xvzf $BB_PKG_NAME.tar.gz
RUN rm -vf $BB_PKG_NAME.tar.gz
RUN mkdir -p /opt
RUN mv $BB_PKG_NAME /opt

# Clean up
RUN rm -rf /var/cache/apk/*

# Define mountable directories
VOLUME ["/data"]

# ADD  bamboo-init.properties config
ADD config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

#  create build id
ARG BUILD_ID=""
RUN echo ${BUILD_ID} > build_id.txt

# Expose ports
EXPOSE 8085

# Define default command.
CMD ["/opt/"$BB_PKG_NAME"/bin/start.sh"]
