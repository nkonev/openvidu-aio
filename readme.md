```bash
docker build . -t nkonev/openvidu-aio:2.16.0.0
docker run -it --rm -e TURN_LISTEN_PORT=3478 -e DOMAIN_OR_PUBLIC_IP=localhost -e OPENVIDU_SECRET=MY_SECRET -e SUPPORT_DEPRECATED_API=false -e SERVER_SSL_ENABLED=false -e SERVER_PORT=5443 -e REDIS_PASSWORD=turn -e REDIS_IP=127.0.0.1 -e REDIS_DB_NAME=0 -e TURN_PUBLIC_IP=auto-ipv4 nkonev/openvidu-aio:2.16.0.0
```