#!/bin/bash -l

set -e

export PATH=./bin:$PATH
export RAILS_ENV=test

echo 'Running karma tests'
echo '-------------------'
RAILS_ENV=development rake karma:install karma:run_once

echo 'Running rspec tests'
echo '-------------------'
bundle exec rspec spec --format html --out tmp/spec.html --format RspecJunitFormatter --profile --format progress --deprecation-out log/rspec_deprecations.txt

echo 'Running cucumber tests'
echo '----------------------'
bundle exec cucumber
