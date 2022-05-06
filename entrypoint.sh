#!/bin/bash

if [ -n "$PUID" ]; then
    PGID=${PGID:-$PUID}
    usermod -o -u "$PUID" user
    groupmod -o -g "$PGID" user
    passwd user <<EOF
user
user
EOF
fi

echo "source /config/bashrc" >> /etc/bash.bashrc
chmod -R 777 /config

if [ -n "$PUID" ]; then
    su user
else
    bash
fi
