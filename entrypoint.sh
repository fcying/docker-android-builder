#!/bin/bash

if [ -n "$PUID" ]; then
    PGID=${PGID:-$PUID}
    echo "uid:$PUID pid:$PGID"
    chmod 644 /config/bashrc
    usermod -o -u "$PUID" user
    groupmod -o -g "$PGID" user
    passwd user <<EOF
user
user
EOF
    su -l user ; exit
else
    bash
fi
