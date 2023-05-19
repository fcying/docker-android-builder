#!/bin/bash

if [ -n "$PUID" ]; then
    PGID=${PGID:-$PUID}
    usermod -o -u "$PUID" user
    groupmod -o -g "$PGID" user
    passwd user <<EOF
user
user
EOF
    su user
else
    bash
fi
