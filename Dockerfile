FROM openjdk:jre-alpine

ARG BUILD_ID=""
ARG BAMBOO_VERSION=""
ARG PORT=""
ARG REF=""

LABEL description="Containerised Atlassian Bomboo Server"
LABEL maintainer="Said Sef <said@saidsef.co.uk> (saidsef.co.uk/)"
LABEL version="6.10.6"
LABEL "uk.co.saidsef.bamboo"="${REF}"

ENV BB_PKG_NAME atlassian-bamboo-${BAMBOO_VERSION:-6.10.6}
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp
ENV PORT ${PORT:-8085}

USER root

# Define working directory.
WORKDIR /data

# Install wget and Download Bamboo
RUN apk add --update --no-cache wget bash && \
    echo $BB_PKG_NAME && \
    wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz && \
    tar xvzf $BB_PKG_NAME.tar.gz && \
    rm -vf $BB_PKG_NAME.tar.gz && \
    mkdir -p /opt && \
    mv $BB_PKG_NAME /opt && \
    rm -rf /var/cache/apk/* && \
    chown nobody:nobody -R /opt/$BB_PKG_NAME

USER nobody

# COPY bamboo-init.properties config
COPY config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

# Define mountable directories
VOLUME ["/data"]

# Expose ports
EXPOSE ${PORT}

# Define default command.
CMD /opt/$BB_PKG_NAME/bin/start-bamboo.sh -fg
