#!/bin/bash

set -e
set -x

# clone app
git clone $1 /app

cd /app
npm install
npm install --save-dev enzyme react-addons-test-utils

cp /ukku/data/MirRunner.test.js /app/src/

CI=true npm test src/MirRunner.test.js 2> /ukku/data/error.txt
