FROM java:8-jre-alpine
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL version="4.1"
LABEL description="Containerised Atlassian Bomboo Server"

# bamboo version
ARG BAMBOO_VERSION=""

ENV BB_PKG_NAME atlassian-bamboo-${BAMBOO_VERSION:-6.2.3}
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp

# Define working directory.
WORKDIR /data

# Install wget and Download Install Bamboo
RUN apk add --update wget && \
    echo $BB_PKG_NAME && \
    wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz && \
    tar xvzf $BB_PKG_NAME.tar.gz && \
    rm -vf $BB_PKG_NAME.tar.gz && \
    mkdir -p /opt && \
    mv $BB_PKG_NAME /opt && \
    rm -rf /var/cache/apk/*

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
