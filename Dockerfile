FROM ubuntu-debootstrap:14.04

RUN apt-get update
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev postgresql-server-dev-9.3 imagemagick nodejs

RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export RBENV_ROOT=~/.rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=~/.rbenv' >> ~/.bashrc
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

RUN bash -l -c 'rbenv install 2.3.0'
RUN bash -l -c 'rbenv global 2.3.0'

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN bash -l -c  'gem install --no-rdoc --no-ri bundler'
RUN bash -l -c  'gem install --no-rdoc --no-ri rails -v 4.2.6'
RUN bash -l -c  'gem install --no-rdoc --no-ri sinatra'
RUN bash -l -c  'gem install --no-rdoc --no-ri rspec'
RUN bash -l -c  'gem install --no-rdoc --no-ri capybara'
RUN bash -l -c  'gem install --no-rdoc --no-ri execjs'
RUN bash -l -c  'gem install --no-rdoc --no-ri phantomjs'
RUN bash -l -c 'ruby -e "require %q{phantomjs}; Phantomjs.platform.ensure_installed!"'
RUN bash -l -c 'apt-get -y install npm'
RUN bash -l -c 'npm install -g http-server'
RUN bash -l -c 'ln -s /usr/bin/nodejs /usr/bin/node'

ADD ./rails.sh /root/
RUN chmod 755 ~/rails.sh

ADD ./sinatra.sh /root/
RUN chmod 755 ~/sinatra.sh
