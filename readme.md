```bash
docker build . -t nkonev/openvidu-aio:2.16.0.0
docker run -it --rm -e DOMAIN_OR_PUBLIC_IP=localhost -e OPENVIDU_SECRET=MY_SECRET -e SERVER_SSL_ENABLED=false -e SERVER_PORT=5443 nkonev/openvidu-aio:2.16.0.0
```


```
root@214a06144e65:/# turnadmin -l -N 'host=localhost dbname=0 password=turn connect_timeout=30'
0: log file opened: /var/log/turn_54_2021-01-14.log
0: Redis DB sync connection success: host=localhost dbname=0 password=turn connect_timeout=30
```