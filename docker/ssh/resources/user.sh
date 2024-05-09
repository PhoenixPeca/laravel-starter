#!/bin/bash
set -e

printf "\n\033[0;44m---> Creating SSH users.\033[0m\n"

for ENV_VARS in $(env); do
    if [[ "${ENV_VARS}" =~ ^SSH_USER_[[:digit:]]+=.*$ ]]; then
        USER_CONF="$(echo ${ENV_VARS} | cut -d'=' -f2)"

        SSH_USER="$(echo ${USER_CONF} | cut -d':' -f1)"
        SSH_PASS="$(echo ${USER_CONF} | cut -d':' -f2)"

        if id ${SSH_USER} > /dev/null 2>&1; then
            printf " * [SKIPPING] User already exists: \033[1;37m${SSH_USER}\033[0m\n"
        else
            useradd -rm -d /home/${SSH_USER} -s /bin/bash -g root -G sudo,www-data "${SSH_USER}" 
            echo "${SSH_USER}:${SSH_PASS}" | chpasswd

            printf " * [SUCCESS] User has been created: \033[1;37m${SSH_USER}\033[0m\n"
        fi
    fi
done

exec "$@"