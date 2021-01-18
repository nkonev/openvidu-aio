```bash
docker build . -t nkonev/openvidu-aio:2.16.0.2
docker run -it --rm -e DOMAIN_OR_PUBLIC_IP=localhost -e OPENVIDU_SECRET=MY_SECRET -e SERVER_SSL_ENABLED=false -e SERVER_PORT=5443 nkonev/openvidu-aio:2.16.0.2
```