#!/bin/bash -l

unset RUBYOPT

version_number=${GO_PIPELINE_COUNTER-0}
revision=`git rev-parse HEAD`
build_date=`date +'%Y-%m-%d %H:%M %z'`

cat > public/version <<EOT
{
  "version":"$version_number",
  "buildDate":"$build_date",
  "gitRevision":"$revision"
}
EOT

# Clean temporary files
rm -rf public/assets vendor/cache coverage log/* tmp/*
BUNDLE_WITHOUT=test:development bundle package --all
RAILS_ENV=assets $precompile_path_option rake assets:precompile

# build RPM
cd ..
/usr/local/rpm_builder/create-rails-rpm $artifact_name $artifact_name $version

#prune packaged gems
rm -rf vendor/cache