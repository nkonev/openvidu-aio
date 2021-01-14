#!/bin/sh

#if [ -f /proc/net/if_inet6 ]; then
#  [ -z "${REDIS_BINDING}" ] && REDIS_BINDING="127.0.0.1 ::1"
#else
  [ -z "${REDIS_BINDING}" ] && REDIS_BINDING="127.0.0.1"
#fi

# redis password - setting default
[[ -z "${COTURN_REDIS_PASSWORD}" ]] && export COTURN_REDIS_PASSWORD=turn

printf "\n"
printf "\n  ======================================="
printf "\n  =            REDIS CONF               ="
printf "\n  ======================================="
printf "\n"

printf "\n  REDIS_BINDING: %s" "${REDIS_BINDING}"
printf "\n  COTURN_REDIS_PASSWORD: %s" "${COTURN_REDIS_PASSWORD}"

mkdir -p /usr/local/etc/redis
cat>/usr/local/etc/redis/redis.conf<<EOF
bind ${REDIS_BINDING}
requirepass ${COTURN_REDIS_PASSWORD}
EOF

printf "\n"
printf "\n  ======================================="
printf "\n  =            START REDIS              ="
printf "\n  ======================================="
printf "\n"

exec redis-server /usr/local/etc/redis/redis.conf
