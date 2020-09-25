source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.2.11.1'

gem 'activerecord-session_store'

##############################################################
# The aes gem is no longer supported, so point to the repo that
# resolves deprecation warnings in Ruby's OpenSSL module.
#
# This could feasibly be replaced by an implementation within
# this repo, as all the gem is doing is wrapping OpenSSL.
##############################################################
gem 'aes', git: 'git@github.com:chicks/aes.git'
gem 'algoliasearch'
gem 'attr_encrypted', '~> 3.1'
gem 'blind_index', '0.2.0'
gem 'bugsnag'
gem 'delayed_job_active_record'
gem 'dotenv'
gem 'draper', '< 3'
gem 'faraday', '0.9.2'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'kss'
gem 'link_header'
gem 'mail'
gem 'mailjet'
gem 'meta-tags', '~> 2.4'
gem 'mysql2', '0.4.9'
gem 'newrelic_rpm'
gem 'nokogiri', '>= 1.10.3'
gem 'nunes'
gem 'opening_hours'
gem 'postcode_anywhere-email_validation', '~> 0.2.0'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'recaptcha', require: 'recaptcha/rails'
gem 'redcarpet'
gem 'rest-client', '~> 2.0'
gem 'rouge'
gem 'rubytree'
gem 'sass-rails'
gem 'statsd-ruby'
gem 'sucker_punch'
gem 'turnout'
gem 'whenever', require: false

# MAS Gems
# ========
# Dependencies
gem 'adal', git: 'git@github.com:moneyadviceservice/azure-activedirectory-library-for-ruby'
gem 'dough-ruby', git: 'git@github.com:moneyadviceservice/dough.git', branch: '11691_DAL_Current-location-warning-message_v5.41', ref: 'a90d79d'
gem 'mas-cms-client', '1.20.0'
# Tools
gem 'mortgage_calculator', '~> 3.13.0'

group :assets do
  gem 'autoprefixer-rails'
  gem 'csslint_ruby'
  gem 'jshint_ruby'
  gem 'uglifier'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'chronic'
  gem 'codeclimate-test-reporter', '0.6.0', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec', '< 2' # DelayedJob integration removed in 2.0.0
  gem 'factory_bot'
  gem 'faker'
  gem 'html_validation'
  gem 'poltergeist'
  gem 'rspec-html-matchers'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem 'sqlite3'
  gem 'tidy-html5'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'syslog-logger'
  gem 'unicorn-rails'
end

group :build, :test, :development do
end

group :test, :development do
  gem 'byebug'
  gem 'chai-jquery-rails'
  gem 'dotenv-rails'
  gem 'ejs'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rack-livereload'
  gem 'rb-readline'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :doc do
  gem 'sdoc', require: false
end
