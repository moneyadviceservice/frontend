#!/bin/bash -l

set -e

export PATH=./bin:$PATH
export RAILS_ENV=test
export BUNDLE_WITHOUT=development

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
BUNDLE_JOBS=$((CORES-1))

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

bundle install --jobs $BUNDLE_JOBS
bower cache clean
bower install --production --config.interactive=false

rake karma:install
rake karma:run_once
rake spec
rake cucumber
