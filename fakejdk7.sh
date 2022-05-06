#!/bin/bash

# ignore android 6 java check
if [ "$1" == "-version" ]; then
    echo "java version "1.7.0_75" OpenJDK Runtime Environment (build 1.7.0_75-b13) OpenJDK 64-Bit Server VM (build 24.75-b04, mixed mode)"
else
    exec $JAVA_HOME/bin/java_origin "$@"
fi
