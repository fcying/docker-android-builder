FROM ubuntu:14.04
MAINTAINER fcying

WORKDIR /mnt

RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
    python-software-properties software-properties-common \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-7-jdk

RUN apt-get install --no-install-recommends -y \
    vim git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip \
    python-dev python-protobuf protobuf-compiler python-virtualenv python-pip \
    bc rsync \
    && pip install pycrypto

RUN useradd -u 999 -d /config -m -G root,sudo user 
COPY init /bin/
COPY jdk /bin/
RUN chmod 770 /bin/init \
    && chmod 770 /bin/jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/bin/init"]

