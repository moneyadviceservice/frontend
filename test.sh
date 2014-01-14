#!/bin/bash -l

set -e -x
export RAILS_ENV=test

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

bundle install

rake spec
