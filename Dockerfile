FROM kurento/kurento-media-server:6.15.0
RUN apt-get update && apt-get install -y redis coturn curl wget dnsutils openjdk-11-jre supervisor && rm -rf /var/lib/apt/lists/*
COPY ./entrypoint_redis.sh /entrypoint_redis.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./discover_my_public_ip.sh /usr/local/bin
COPY ./entrypoint_openvidu.sh /entrypoint_openvidu.sh
RUN chmod +x /usr/local/bin/discover_my_public_ip.sh
RUN mv /entrypoint.sh /entrypoint_kms.sh
# Exec supervisord
CMD ["/usr/bin/supervisord"]