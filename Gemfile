source 'https://rubygems.org'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.1.0.rc1'

gem 'draper', '~> 1.3.0'
gem 'faraday_middleware'
gem 'foreman'
gem 'gaffe'
gem 'kss'
gem 'link_header'
gem 'meta-tags', require: 'meta_tags', github: 'moneyadviceservice/meta-tags', branch: 'alternate-url'
gem 'nokogiri'
gem 'nunes'
gem 'rouge'
gem 'statsd-ruby'

group :assets do
  gem 'autoprefixer-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
end

group :development do
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-sass'
  gem 'guard-shell'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'thin'
  gem 'vcr'
  gem 'webmock'
  gem 'html_validation' # requires https://github.com/safarijv/tidy-html5
end

group :production do
  gem 'activerecord-session_store'
  gem 'mysql2'
  gem 'syslog-logger'
  gem 'unicorn-rails'
end

group :test, :development do
  gem 'ejs'
  gem 'dotenv-rails'
  gem 'mas-development_dependencies',
      git: 'https://github.com/moneyadviceservice/mas-development_dependencies.git'
  gem 'chai-jquery-rails'
  gem 'byebug'
  gem 'sqlite3' # the database is not used yet, so sqlite is sufficient
end

group :doc do
  gem 'sdoc', require: false
end
