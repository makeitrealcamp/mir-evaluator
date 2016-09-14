#!/bin/bash

set -e
set -x

# clone app
git clone $1 /app

cd /app

if [ ! -f Gemfile ]; then
  echo "No se encontró el archivo Gemfile en la raiz del proyecto." >> /ukku/data/error.txt
  exit 1
fi

bundle install --jobs=1 --path=/ukku/bundler-cache -j4 --binstubs=vendor/bundle/bin 2> /ukku/data/error.txt
RAILS_ENV=test bundle exec rake db:migrate 2> /ukku/data/error.txt

# run template
bundle exec rake rails:template LOCATION=/ukku/data/rails_template.rb 2> /ukku/data/error.txt
bundle install --jobs=1 --path=/ukku/bundler-cache -j4 --binstubs=vendor/bundle/bin 2> /ukku/data/error.txt

# setup spec
if [ -d "spec" ]; then
  rm -rf spec
fi

bundle exec rails generate rspec:install 2> /ukku/data/error.txt
cp /ukku/data/makeitreal_spec.rb spec/
echo "Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
" >> spec/rails_helper.rb

bundle exec rspec spec --format j --fail-fast --out /ukku/data/result.json 2> /ukku/data/error.txt
