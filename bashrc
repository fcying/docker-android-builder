export HISTFILE=/config/bash_history
. /usr/share/bash-completion/bash_completion
alias ll='ls -alh --time-style=long-iso'
alias ls='ls --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

export USER=$(whoami)
export LC_ALL=C

export USE_CCACHE=1
export CCACHE_DIR=/mnt/.ccache
ccache -M 50G

function jack_server() {
    if [ "$1" == "restart" ]; then
        /mnt/out/host/linux-x86/bin/jack-admin kill-server && /mnt/out/host/linux-x86/bin/jack-admin start-server
    else
        export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx$1"
        /mnt/out/host/linux-x86/bin/jack-admin kill-server && /mnt/out/host/linux-x86/bin/jack-admin start-server
    fi
}

if [ "$JDK" == 7 ]; then
    export JAVA_HOME=/opt/jdk_1.7.0_75
    export JRE_HOME=/opt/jdk_1.7.0_75
    export PATH=$JAVA_HOME/bin:$PATH
fi
