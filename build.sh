#!/bin/bash -l

set -e

unset RUBYOPT
export PATH=./bin:$PATH
export BUNDLE_WITHOUT="test:development"

version_number=${GO_PIPELINE_LABEL-0}
revision=`git rev-parse HEAD`
build_date=`date +'%Y-%m-%d %H:%M %z'`

cat > public/version <<EOT
{
  "version":"$version_number",
  "buildDate":"$build_date",
  "gitRevision":"$revision"
}
EOT

echo "Cleaning temporary files"
echo "----"
rm -rf public/assets vendor/cache coverage log/* tmp/* .bundle/config

echo "Running Bundle package"
echo "----"
time bundle package --all

echo "Running Bower cache clean"
echo "----"
time bower cache clean

echo "Purging bower components"
echo "----"
[ -d vendor/assets/bower_components ] && rm -r vendor/assets/bower_components

echo "Running Bower update (via bowndler)"
echo "----"
time bowndler update --production --config.interactive=false

echo "Precompiling assets"
echo "----"
time RAILS_ENV=production RAILS_GROUPS=assets rake assets:precompile

echo "Uploading assets"
echo "----"
time /usr/local/bin/upload-responsive-assets.sh $(pwd)/public ${RESPONSIVE_ASSET_CONTAINER}

echo "Creating RPM"
echo "----"
cd ..
time /usr/local/rpm_builder/create-rails-rpm $artifact_name $artifact_name $version_number
