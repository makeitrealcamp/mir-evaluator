FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev postgresql-server-dev-9.5 imagemagick
RUN apt-get -y install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libexpat1 libfontconfig1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install unzip
RUN apt-get -y install nodejs

RUN apt-get install -y tzdata

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> /etc/profile.d/yarn.sh

RUN curl https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/526987/chrome-linux.zip --output /tmp/chromium-browser.zip && unzip /tmp/chromium-browser.zip -d /root

RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export RBENV_ROOT=~/.rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=~/.rbenv' >> ~/.bashrc
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

RUN bash -l -c 'rbenv install 2.3.1'
RUN bash -l -c 'rbenv global 2.3.1'

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN bash -l -c  'gem install --no-rdoc --no-ri bundler'
RUN bash -l -c  'gem install --no-rdoc --no-ri rails -v 5.0.2'
RUN bash -l -c  'gem install --no-rdoc --no-ri sinatra'
RUN bash -l -c  'gem install --no-rdoc --no-ri rspec'
RUN bash -l -c  'gem install --no-rdoc --no-ri capybara'
RUN bash -l -c  'gem install --no-rdoc --no-ri execjs'
RUN bash -l -c  'gem install --no-rdoc --no-ri phantomjs -v 2.1.1.0'
RUN bash -l -c 'ruby -e "require %q{phantomjs}; Phantomjs.platform.ensure_installed!"'
RUN bash -l -c 'npm install -g http-server'
RUN bash -l -c 'npm install -g mocha'
RUN bash -l -c 'npm install -g sinon'
RUN bash -l -c 'npm install -g chai'

ADD ./rails.sh /root/
RUN chmod 755 /root/rails.sh

ADD ./sinatra.sh /root/
RUN chmod 755 /root/sinatra.sh

ADD ./react.sh /root/
RUN chmod 755 /root/react.sh
