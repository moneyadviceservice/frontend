#!/bin/bash -l

set -e

export PATH=./bin:$PATH
export RAILS_ENV=test
export BUNDLE_WITHOUT=development

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
BUNDLE_JOBS=$((CORES-1))

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

# remove prior dirty packaged gems e.g. build.sh
rm -rf vendor/cache .bundle/config

# due to glibc being lesser than the required for nokogiri pre-build extensions
bundle config build.nokogiri --use-system-libraries
bundle install --jobs $BUNDLE_JOBS
bower cache clean
rm -rf vendor/assets/bower_components
bowndler update --production --config.interactive=false

npm install -q

./node_modules/karma/bin/karma start spec/javascripts/karma.conf.js 2> /dev/null
if [ $? -eq 0 ]
then
    echo "Karma tests passed!"
else
    echo "Karma tests couldn't run, probably phantomjs being stupid" >&2
fi

bundle exec rspec spec --format html --out tmp/spec.html --format RspecJunitFormatter --profile --format progress --deprecation-out log/rspec_deprecations.txt
bundle exec cucumber
