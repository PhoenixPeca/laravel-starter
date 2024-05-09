#!/bin/bash
set -e

printf "Initializing...\n"
chmod 600 /etc/ssh/*_key
chmod 644 /etc/ssh/*_key.pub
chmod 644 /etc/ssh/moduli

/usr/local/bin/user.sh

printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"
service ssh start
service ssh status

printf "\n\033[0;44m---> Fixing data files permission.\033[0m\n"
chmod -R 775 /var/web && chown -R www-data:www-data /var/web

printf "\n\033[0;44m---> Going on standby...\033[0m\n"
sleep infinity

exec "$@"