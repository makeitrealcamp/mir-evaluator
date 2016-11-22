#!/bin/bash

set -e
set -x

# clone app
git clone $1 /app

npm install

CI=true npm test
