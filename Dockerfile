FROM debian:jessie
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL version="3.0"
LABEL description="Containerised Bomboo Server"

ENV BB_PKG_NAME atlassian-bamboo-5.13.2
ENV PATH /opt/$BB_PKG_NAME/bin:$PATH
ENV HOME /tmp
ENV DEBIAN_FRONTEND noninteractive

# Define working directory.
WORKDIR /data

# Install Oracle JAVA 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get -yq update && \
  apt-get install python-software-properties && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get -yq update && \
  apt-get install -yq oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get -yq clean && \
  apt-get -yq autoclean

# Install Bamboo
RUN echo ${BB_PKG_NAME}
RUN wget https://my.atlassian.com/software/bamboo/downloads/binary/${BB_PKG_NAME}.tar.gz
RUN tar xvzf ${BB_PKG_NAME}.tar.gz
RUN rm -vf ${BB_PKG_NAME}.tar.gz
RUN mv $BB_PKG_NAME /opt

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
CMD ["/opt/$BB_PKG_NAME/bin/start.sh"]
