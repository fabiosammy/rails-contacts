FROM ruby:2.5.1
MAINTAINER fabiosammy <fabiosammy@gmail.com>

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  openssh-server \
  bison \
  libgdbm-dev \
  ruby \
  locales \
  mysql-client \
  postgresql-client \
  sqlite3 \
  nodejs \
  sudo \
  cmake \
  graphviz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# skip installing gem documentation
RUN mkdir -p /usr/local/etc && { echo 'install: --no-document'; echo 'update: --no-document'; } >> /usr/local/etc/gemrc

# SSH config
RUN mkdir /var/run/sshd \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && echo "export VISIBLE=now" >> /etc/profile \
  && echo 'root:root' | chpasswd

ENV NOTVISIBLE "in users profile"
ENV HOME=/home/devel
ENV APP=/var/www/app

# ADD an user
RUN adduser --disabled-password --gecos '' devel \
  && usermod -a -G sudo devel \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo 'devel:devel' | chpasswd

# SET ENV Gems
ENV GEM_HOME=$APP/.bundle/ruby/${RUBY_MAJOR}.0
ENV BUNDLE_PATH="$GEM_HOME" \
  BUNDLE_BIN="$GEM_HOME/bin" \
  BUNDLE_SILENCE_ROOT_WARNING=1 \
  BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH=$BUNDLE_BIN:$PATH

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p $HOME \
  && mkdir -p $APP \
  && mkdir -p $GEM_HOME \
  && mkdir -p $BUNDLE_BIN \
  && echo "PATH=$PATH" >> /etc/profile \
  && echo "export GEM_HOME=$GEM_HOME" >> /etc/profile \
  && echo "export BUNDLE_APP_CONFIG=$GEM_HOME" >> /etc/profile \
  && echo "export GEM_PATH=$APP/.bundle" >> /etc/profile \
  && echo "export BUNDLE_PATH=$APP/.bundle" >> /etc/profile \
  && echo "PATH=$PATH" >> /etc/environment \
  && echo "GEM_HOME=$GEM_HOME" >> /etc/environment \
  && echo "BUNDLE_APP_CONFIG=$GEM_HOME" >> /etc/environment \
  && echo "GEM_PATH=$APP/.bundle" >> /etc/environment \
  && echo "BUNDLE_PATH=$APP/.bundle" >> /etc/environment \
  && gem update --system $RUBYGEMS_VERSION \
  && chown -R devel:devel $HOME \
  && chown -R devel:devel $APP

USER devel:devel
WORKDIR $APP

# Copy the main application.
#COPY . ./

# Install bundler to user and update path
ENV BUNDLE_GEMFILE=$APP/Gemfile \
  GEM_PATH=$APP/.bundle
RUN gem update --system \
  && gem install bundler \
  && bundle config path "$GEM_HOME" \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && bundle config --global jobs $(nproc)

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
#COPY Gemfile Gemfile.lock ./
#RUN bundle install --retry 5

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 22
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D"]

