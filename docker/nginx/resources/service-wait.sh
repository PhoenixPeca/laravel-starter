#!/bin/bash

ME=$(basename ${0})
SERVER_HOST="php-fpm"
SERVER_PORT="9000"

x=1
while [ ${x} -le 5 ]; do
    echo >&3 "${ME}: info: probing ${SERVER_HOST} status (trial $x of 5)"
    if (nmap ${SERVER_HOST} -p ${SERVER_PORT} | grep -q "${SERVER_PORT}\/tcp\sopen.*"); then
        echo >&3 "${ME}: info: service ${SERVER_HOST} is online"
        exit 0
    elif [ ${x} == 5 ]; then
        echo >&3 "${ME}: error: service ${SERVER_HOST} cannot be reached"
        exit 1
    fi
    echo >&3 "${ME}: warning: service ${SERVER_HOST} is offline"
    x=$(( ${x} + 1 ))
    sleep 40s
done
