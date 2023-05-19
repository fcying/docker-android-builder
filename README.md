# docker-android-builder
easy build android  
build test for aosp 6 ~ aosp 13

#### config
* /mnt  
    default workspace

* PUID  
    if not none, use user `user`, passwd `user`, else use `root`

* GUID  
    default same with `PUID`

* JDK  
    set jdk version.(JDK=7 or JDK=8)

* /config/bash_history  
    default is empty

* /config/bashrc  
    default bash config

#### usage

* custom bash_history
```shell
$ cd aosp
$ docker run -it --rm -v $(pwd)/:/mnt -v ~/.bash_history:/config/bash_history fcying/android-builder:latest
$ source build/envsetup.sh
$ lunch
$ make
```

* custom UID
```shell
$ docker run -it --rm -v $(pwd)/:/mnt -e "PUID=$(id -u)" fcying/android-builder:latest
```

* if build android6.0, must swith to openjdk7
```shell
$ docker run -it --rm -e "JDK=7" -v $(pwd)/:/mnt fcying/android-builder:latest
or run `JDK 7` in container
```

* jack_server memory setting
```shell
$ jack_server 4096m
$ jack_server restart
```
