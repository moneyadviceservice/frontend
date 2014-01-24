#!/bin/bash -l

set -e -x

export PATH=./bin:$PATH
export RAILS_ENV=test
export BUNDLE_WITHOUT=development

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

gem uninstall -aIx spring

bundle install

rake spec
rake cucumber
