FROM docker.io/openjdk:22-slim

ARG BUILD_ID=""
ARG BAMBOO_VERSION="9.2.4"
ARG PORT=""
ARG REF=""

LABEL org.opencontainers.image.description="Containerised Atlassian Bamboo Server"
LABEL maintainer="Said Sef <said@saidsef.co.uk> (saidsef.co.uk/)"
LABEL "uk.co.saidsef.bamboo"="${REF}"

ENV BAMBOO_HOME /data
ENV BB_PKG_NAME atlassian-bamboo-${BAMBOO_VERSION}
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp
ENV PORT ${PORT:-8085}

USER root

# Define working directory.
WORKDIR $BAMBOO_HOME

# Install wget and Download Bamboo
RUN apt-get update && \
    apt-get install -yq wget curl && \
    echo $BB_PKG_NAME && \
    wget https://www.atlassian.com/software/bamboo/downloads/binary/$BB_PKG_NAME.tar.gz && \
    tar xvzf $BB_PKG_NAME.tar.gz && \
    rm -vf $BB_PKG_NAME.tar.gz && \
    mkdir -p /opt && \
    mv $BB_PKG_NAME /opt/atlassian-bamboo

# COPY bamboo-init.properties config
COPY config/bamboo-init.properties /opt/atlassian-bamboo/WEB-INF/classes/
COPY config/bamboo-init.properties /opt/atlassian-bamboo/

# Fix dir permissions/ownership
RUN chmod a+rwx /opt/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties && \
    chown nobody:nobody -R /opt/atlassian-bamboo

USER nobody

# Define mountable directories
VOLUME ["/data"]

# Expose ports
EXPOSE ${PORT}

# Define default command.
CMD /opt/atlassian-bamboo/bin/start-bamboo.sh -fg
