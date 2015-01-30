FROM ubuntu:14.04
MAINTAINER Carles Amigó, carles.amigo@socialpoint.es

ENV PUPPET_VERSION 3.7.1
ENV RUBY_VERSION 1.9.3-p551

RUN apt-get update && apt-get install -y \
      autoconf \
      automake \
      bison \
      curl \
      g++ \
      gawk \
      gcc \
      libc6-dev \
      libffi-dev \
      libgdbm-dev \
      libncurses5-dev \
      libreadline6-dev \
      libsqlite3-dev \
      libssl-dev \
      libtool \
      libyaml-dev \
      make \
      patch \
      patch \
      pkg-config \
      sqlite3 \
      zlib1g-dev

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s -- --path /var/tmp stable
RUN /bin/bash -l -c "rvm install ruby-$RUBY_VERSION"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install puppet -v $PUPPET_VERSION"
COPY entrypoint.sh /

ENTRYPOINT /bin/bash -l -c "/entrypoint.sh $0 $*"
