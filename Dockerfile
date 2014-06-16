FROM debian

MAINTAINER Tsuyoshi CHO <Tsuyoshi.CHO+develop@Gmail.com>

# mirror
RUN echo "deb http://cdn.debian.net/debian/ wheezy main contrib non-free" > /etc/apt/sources.list.d/mirror.jp.list
RUN echo "deb http://cdn.debian.net/debian/ wheezy-updates main contrib" >> /etc/apt/sources.list.d/mirror.jp.list
RUN /bin/rm /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive LANG
RUN apt-get update

# set locale
RUN apt-get install -y --no-install-recommends apt-utils locales

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8

# apt package
RUN apt-get install -y --no-install-recommends git
RUN apt-get install -y --no-install-recommends ca-certificates openssl
RUN apt-get install -y --no-install-recommends fontforge
RUN apt-get install -y --no-install-recommends ttf-inconsolata fonts-migmix
RUN apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

# git clone
RUN git clone https://github.com/yascentur/Ricty.git

# comment out:revert previous commit change 
# if you use docker 1.0 or later; uncomment OK
# work on /Ricty
#WORKDIR /Ricty

# copy script to docker image
#COPY build.sh /Ricty/build.sh

ENTRYPOINT "/bin/bash"
