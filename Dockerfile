FROM ubuntu:18.04

ARG OPENVIDU_VERSION=2.16.0

# Install kurento
# https://doc-kurento.readthedocs.io/en/6.15.0/user/installation.html#local-installation
#RUN apt-get update && apt-get install --no-install-recommends --yes gnupg && \
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5AFA7A83 && \
# echo 'deb [arch=amd64] http://ubuntu.openvidu.io/6.15.0 bionic kms6' > /etc/apt/sources.list.d/kurento.list
#RUN apt-get update && apt-get install --no-install-recommends --yes kurento-media-server
# https://github.com/Kurento/kurento-docker/tree/master/kurento-media-server
COPY ./entrypoint_kms.sh /entrypoint_kms.sh
RUN apt-get update
# Install other dependencies
RUN apt-get install --no-install-recommends -y redis coturn curl wget dnsutils supervisor
RUN rm -rf /var/lib/apt/lists/*

# Install Openvidu
# https://github.com/OpenVidu/openvidu/tree/master/openvidu-server/docker/openvidu-server
#RUN mkdir -p /opt/openvidu && cd /opt/openvidu && wget https://github.com/OpenVidu/openvidu/releases/download/v${OPENVIDU_VERSION}/openvidu-server-${OPENVIDU_VERSION}.jar && mv openvidu-server-${OPENVIDU_VERSION}.jar openvidu-server.jar && echo ${OPENVIDU_VERSION} > VERSION
COPY ./entrypoint_openvidu.sh /entrypoint_openvidu.sh

COPY ./discover_my_public_ip.sh /usr/local/bin
RUN chmod +x /usr/local/bin/discover_my_public_ip.sh

COPY ./entrypoint_redis.sh /entrypoint_redis.sh
COPY ./entrypoint_coturn.sh /entrypoint_coturn.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exec supervisord
ENTRYPOINT ["/usr/bin/supervisord"]