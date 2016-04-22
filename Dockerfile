# Container running Event Store
#
# VERSION               0.1
FROM ubuntu:trusty

# That's me :)
MAINTAINER Thomas Ploch "thomas.ploch@tp-solutions.de"

# Set up required env vars
ENV DEBIAN_FRONTEND=noninteractive \
  EVENTSTORE_INT_HTTP_PREFIXES=http://127.0.0.1:2112/ \
  EVENTSTORE_EXT_HTTP_PREFIXES=http://*:2113/ \
  EVENTSTORE_INT_IP=127.0.0.1 \
  EVENTSTORE_EXT_IP=0.0.0.0 \
  EVENTSTORE_ADD_INTERFACE_PREFIXES=0

# Install wget and https transport for apt
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  curl

RUN curl -s https://packagecloud.io/install/repositories/EventStore/EventStore-OSS/script.deb.sh | sudo bash

RUN apt-get install eventstore-oss=3.5.0

# Expose the public/internal ports
EXPOSE 2113 1113 2112 1112

# Create the volumes
VOLUME /data/logs 
VOLUME /data/db

# Run as eventstore user
USER root

# set entry point to eventstore executable
ENTRYPOINT ["eventstored", "--log=/data/logs", "--db=/data/db", "--run-projections=all"]
