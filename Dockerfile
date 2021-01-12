FROM ubuntu:20.04
RUN apt-get update && apt-get install -y redis openjdk-11-jre coturn curl wget dnsutils supervisor
RUN rm -rf /var/lib/apt/lists/*
COPY ./entrypoint_redis.sh /entrypoint_redis.sh
COPY ./entrypoint_coturn.sh /entrypoint_coturn.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./discover_my_public_ip.sh /usr/local/bin
COPY ./entrypoint_openvidu.sh /entrypoint_openvidu.sh
RUN chmod +x /usr/local/bin/discover_my_public_ip.sh
#RUN mv /entrypoint.sh /entrypoint_kms.sh
# Exec supervisord
ENTRYPOINT ["/usr/bin/supervisord"]