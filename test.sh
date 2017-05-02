#!/bin/bash -l

set -ex

export PATH=./bin:$PATH
echo PATH=$PATH
exit 1

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
BUNDLE_JOBS=$((CORES-1))

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

# remove prior dirty packaged gems e.g. build.sh
rm -rf vendor/cache .bundle/config

cp config/features.yml.sample config/features.yml

bundle install --jobs $BUNDLE_JOBS
bower cache clean
rm -rf vendor/assets/bower_components
bowndler update --production --config.interactive=false

RAILS_ENV=development rake karma:install karma:run_once
bundle exec rspec spec --format html --out tmp/spec.html --format RspecJunitFormatter --profile --format progress --deprecation-out log/rspec_deprecations.txt
bundle exec cucumber
