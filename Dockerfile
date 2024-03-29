FROM ubuntu:16.04

RUN apt-get upgrade
RUN apt-get update
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2 libxslt1-dev libxslt-dev libcurl4-openssl-dev python-software-properties libffi-dev postgresql-server-dev-9.5 imagemagick
RUN apt-get -y install pkg-config gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libexpat1 libfontconfig1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get -y install nodejs unzip tzdata

RUN npm install -g yarn

RUN curl https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/526987/chrome-linux.zip --output /tmp/chromium-browser.zip && unzip /tmp/chromium-browser.zip -d /root

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

RUN bash -l -c 'curl -sSL https://get.rvm.io | bash'
RUN usermod -a -G rvm root

RUN echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"' >> ~/.bashrc

RUN bash -l -c 'rvm install 2.7.6'
RUN bash -l -c 'rvm use 2.7.6 --default'

RUN echo "gem: --no-document" > ~/.gemrc
RUN bash -l -c  'gem install --no-document bundler -v 1.17.3'
RUN bash -l -c  'gem install --no-document rails -v 6.0.2'
RUN bash -l -c  'gem install --no-document sinatra'
RUN bash -l -c  'gem install --no-document rspec'
RUN bash -l -c  'gem install --no-document capybara'
RUN bash -l -c  'gem install --no-document execjs'
RUN bash -l -c  'gem install --no-document phantomjs -v 2.1.1.0'
RUN bash -l -c  'gem install --no-document sassc -v 2.2.1'
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

RUN bash -l -c 'rvm install 2.5.1'
RUN bash -l -c 'rvm install 2.5.3'
RUN bash -l -c 'rvm install 2.5.8'
RUN bash -l -c 'rvm install 2.4.5'
RUN bash -l -c 'rvm install 2.6.0'
RUN bash -l -c 'rvm install 2.6.1'
RUN bash -l -c 'rvm install 2.5.5'
RUN bash -l -c 'rvm install 2.5.7'
RUN bash -l -c 'rvm install 2.6.2'
RUN bash -l -c 'rvm install 2.6.3'
RUN bash -l -c 'rvm install 3.0.2'
RUN bash -l -c 'rvm install 3.1.2'
