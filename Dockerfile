FROM ubuntu:18.04
MAINTAINER fcying

WORKDIR /mnt

RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
    git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    vim bash-completion wget rsync \
    ccache bc openjdk-8-jdk python-pip python3-pip \
    && wget -O/usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
    && chmod +x /usr/bin/repo \
    && pip install -i https://repo.huaweicloud.com/repository/pypi/simple pycryptodome \
    && pip3 install -i https://repo.huaweicloud.com/repository/pypi/simple pycryptodome \
    && wget https://download.java.net/openjdk/jdk7u75/ri/openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz -Oopenjdk7.tgz \
    && tar xzvf openjdk7.tgz && rm openjdk7.tgz \
    && mv java-se-7u75-ri /opt/jdk_1.7.0_75 \
    && mv /opt/jdk_1.7.0_75/bin/java /opt/jdk_1.7.0_75/bin/java_origin \
    && sed -i "s@jdk.tls.disabledAlgorithms=SSLv3, TLSv1, TLSv1.1@jdk.tls.disabledAlgorithms=SSLv3@" /etc/java-8-openjdk/security/java.security \
    && mkdir /config && chmod 777 /config

RUN useradd -u 999 -d /home/user -m -G root,sudo user
COPY entrypoint.sh /
COPY bashrc /config/
COPY fakejdk7.sh /opt/jdk_1.7.0_75/bin/java
RUN chmod 770 /entrypoint.sh \
    && chmod 770 /opt/jdk_1.7.0_75/bin/java \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/entrypoint.sh"]

