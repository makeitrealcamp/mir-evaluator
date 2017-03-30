#!/bin/bash

set -e
set -x

# clone app
git clone $1 /app

cd /app
yarn config set cache-folder /ukku/yarn-cache
yarn
yarn add --save-dev enzyme react-addons-test-utils

cp /ukku/data/MirRunner.test.js /app/src/

CI=true yarn test src/MirRunner.test.js 2> /ukku/data/error.txt
