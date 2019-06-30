FROM openjdk:jre-alpine
MAINTAINER Said Sef <said@saidsef.co.uk> (saidsef.co.uk/)

# build_id, bamboo version
ARG BUILD_ID=""
ARG BAMBOO_VERSION=""
ARG PORT=""
ARG REF=""

LABEL version="6.8"
LABEL description="Containerised Atlassian Bomboo Server"
LABEL "uk.co.saidsef.bamboo"="${REF}"

ENV BB_PKG_NAME atlassian-bamboo-${BAMBOO_VERSION:-6.8.3}
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp
ENV PORT ${PORT:-8085}

# Define working directory.
WORKDIR /data

# Install wget and Download Install Bamboo
RUN apk add --update --no-cache wget && \
    echo $BB_PKG_NAME && \
    wget https://my.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz && \
    tar xvzf $BB_PKG_NAME.tar.gz && \
    rm -vf $BB_PKG_NAME.tar.gz && \
    mkdir -p /opt && \
    mv $BB_PKG_NAME /opt && \
    rm -rf /var/cache/apk/*

# ADD  bamboo-init.properties config
ADD config/bamboo-init.properties /opt/$BB_PKG_NAME/WEB-INF/classes/bamboo-init.properties

# Define mountable directories
VOLUME ["/data"]

#  create build id
RUN echo ${TAG} > build_id.txt

# Expose ports
EXPOSE ${PORT}

# Define default command.
CMD ["/opt/"$BB_PKG_NAME"/bin/start.sh"]
