FROM ubuntu:23.04

# build package install
ENV BUILD_PACKAGES="autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev libyaml-dev"
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends $BUILD_PACKAGES

# user package install
ENV RUNTIME_PACKAGES="git vim curl unzip tzdata less sudo ca-certificates"
RUN apt-get install -y --no-install-recommends $RUNTIME_PACKAGES

# node
ARG NODE_VERSION=lts
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts
RUN npm install -g npm && npm install -g n 
RUN n $NODE_VERSION

# user
ARG USERNAME=developer
ARG GROUPNAME=developer
ARG UID=1001
ARG GID=1001
RUN groupadd -g 4000 admin
RUN [ $UID -eq 1000 ] && sh -c "usermod -l $USERNAME ubuntu && groupmod -n ${GROUPNAME} ubuntu && usermod -aG admin $USERNAME" || sh -c "groupadd -g $GID $GROUPNAME; useradd -m -s /bin/bash -u $UID -g $GID -G admin $USERNAME"
RUN mkdir /app && chown $USERNAME /app
USER $USERNAME

# rbenv
ARG RUBY_VERSION=3.2.2
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV PATH ~/.rbenv/shims:~/.rbenv/bin:$PATH

RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    ~/.rbenv/bin/rbenv install $RUBY_VERSION && \
    ~/.rbenv/bin/rbenv global $RUBY_VERSION

# app directory
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# bundle install
RUN ~/.rbenv/bin/rbenv exec gem install bundler
RUN ~/.rbenv/bin/rbenv exec bundle config path 
RUN ~/.rbenv/bin/rbenv exec bundle

CMD ["rails", "server", "-b", "0.0.0.0"]

# 必要なら起動後unminimizeする