FROM debian:jessie
MAINTAINER Carles Amigó, carles.amigo@socialpoint.es

ENV PUPPET_VERSION 3.7.1
ENV RUBY_VERSION 1.9.3-p551

RUN apt-get update && apt-get install -y \
      autoconf \
      automake \
      bison \
      bzip2 \
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
RUN /bin/bash -l -c "rvm install ruby-$RUBY_VERSION --disable-binary --movable"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install puppet -v $PUPPET_VERSION"
RUN cp /lib/x86_64-linux-gnu/libc.so.6 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib/x86_64-linux-gnu/libpthread.so.0 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib/x86_64-linux-gnu/librt.so.1 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib/x86_64-linux-gnu/libdl.so.2 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib/x86_64-linux-gnu/libcrypt.so.1 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib/x86_64-linux-gnu/libm.so.6 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
RUN cp /lib64/ld-linux-x86-64.so.2 /var/tmp/rubies/ruby-$RUBY_VERSION/lib/
COPY entrypoint.sh /

ENTRYPOINT /bin/bash -l -c "/entrypoint.sh $0 $*"
