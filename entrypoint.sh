#!/bin/bash

PUID=${PUID:-999}
PGID=${PGID:-$PUID}

usermod -o -u "$PUID" user
groupmod -o -g "$PGID" user
passwd user <<EOF
.
.
EOF

{
    echo "function jack_server() {"
    echo "    if [ \"\$1\" == \"restart\" ]; then"
    echo "        /mnt/out/host/linux-x86/bin/jack-admin kill-server && /mnt/out/host/linux-x86/bin/jack-admin start-server"
    echo "    else"
    echo "        export JACK_SERVER_VM_ARGUMENTS=\"-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx\$1\""
    echo "    fi"
    echo "}"
} >> /etc/bash.bashrc

{
    echo "export USE_CCACHE=1"
    echo "export CCACHE_DIR=/mnt/.ccache"
    echo "ccache -M 50G" 
} >> /etc/bash.bashrc

if [ "$JDK" == 7 ]; then
    jdk 7 > /dev/null
else
    jdk 8 > /dev/null
fi
su user
