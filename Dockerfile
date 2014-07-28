FROM debian:wheezy

MAINTAINER Tsuyoshi CHO <Tsuyoshi.CHO+develop@Gmail.com>

ENV VERSION 3.2.3

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

# mirror
RUN echo "deb http://cdn.debian.net/debian/ wheezy main contrib non-free" > /etc/apt/sources.list.d/mirror.jp.list
RUN echo "deb http://cdn.debian.net/debian/ wheezy-updates main contrib" >> /etc/apt/sources.list.d/mirror.jp.list
RUN /bin/rm /etc/apt/sources.list

RUN apt-get update

# set locale
RUN apt-get install -y --no-install-recommends apt-utils locales && \
    echo en_US.UTF-8 UTF-8 > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# apt package
RUN apt-get install -y --no-install-recommends git ca-certificates openssl
RUN apt-get install -y --no-install-recommends fontforge ttf-inconsolata fonts-migmix

RUN apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# git clone
RUN git clone https://github.com/yascentur/Ricty.git

# work on /Ricty
WORKDIR /Ricty

RUN git checkout $VERSION

CMD ["./ricty_generator.sh", "auto"]
