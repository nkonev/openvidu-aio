#!/bin/bash

# Set debug mode
DEBUG=${DEBUG:-false}
[ "$DEBUG" == "true" ] && set -x

#Check parameters
[[ "${TURN_PUBLIC_IP}" == "auto-ipv4" ]] && export TURN_PUBLIC_IP=$(/usr/local/bin/discover_my_public_ip.sh)
[[ "${TURN_PUBLIC_IP}" == "auto-ipv6" ]] && export TURN_PUBLIC_IP=$(/usr/local/bin/discover_my_public_ip.sh --ipv6)
[[ -z "${ENABLE_COTURN_LOGS}" ]] && export ENABLE_COTURN_LOGS=true

echo "TURN public IP: ${TURN_PUBLIC_IP:-"empty"}"

[[ ! -z "${TURN_LISTEN_PORT}" ]] && echo "TURN listening port: ${TURN_LISTEN_PORT}" ||
    { echo "TURN_LISTEN_PORT environment variable is not defined"; exit 1; }

[[ ! -z "${MIN_PORT}" ]] && echo "Defined min port coturn: ${MIN_PORT}" || echo "Min port coturn: 40000"

[[ ! -z "${MAX_PORT}" ]] && echo "Defined max port coturn: ${MAX_PORT}" || echo "Max port coturn: 65535"

# Load configuration files of coturn
# Enable turn
cat>/etc/default/coturn<<EOF
TURNSERVER_ENABLED=1
EOF

# Turn server configuration
cat>/etc/turnserver.conf<<EOF
listening-port=${TURN_LISTEN_PORT}
fingerprint
lt-cred-mech
max-port=${MAX_PORT:-65535}
min-port=${MIN_PORT:-40000}
simple-log
pidfile="/var/run/turnserver.pid"
realm=openvidu
verbose
EOF

if [[ ! -z "${TURN_PUBLIC_IP}" ]]; then
    echo "external-ip=${TURN_PUBLIC_IP}" >> /etc/turnserver.conf
fi

if [[ ! -z "${REDIS_IP}" ]] && [[ ! -z "${DB_NAME}" ]] && [[ ! -z "${DB_PASSWORD}" ]]; then
    echo "redis-userdb=\"ip=${REDIS_IP} dbname=${DB_NAME} password=${DB_PASSWORD} connect_timeout=30\"" >> /etc/turnserver.conf
fi

if [[ ! -z "${TURN_USERNAME_PASSWORD}" ]]; then
    echo "user=${TURN_USERNAME_PASSWORD}" >> /etc/turnserver.conf
fi


if [[ "${ENABLE_COTURN_LOGS}" == "true" ]]; then
    exec /usr/bin/turnserver -c /etc/turnserver.conf -v --log-file /dev/null
else
    exec /usr/bin/turnserver -c /etc/turnserver.conf -v --log-file /dev/null --no-stdout-log
fi