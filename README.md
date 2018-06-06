# docker-android-builder
  
default passwd is `.`
  
```shell
cd aosp
docker run -it --rm --name android_builder -e "PUID=$(id -u)" -v $(pwd)/:/mnt -v /etc/localtime:/etc/localtime:ro fcying/android_builder:latest
```
  
if build android6.0, must swith to openjdk7
```shell
sudo jdk 7
or
docker run -it --rm --name android_builder -e "JDK=7" -e "UID=$(id -u)" -v $(pwd)/:/mnt fcying/android_builder:latest
```
  
jack_server setting
```shell
jack_server 4096m
jack_server restart
```
  
test passed in spreadtrum android7; mtk android6, android7; aosp;
