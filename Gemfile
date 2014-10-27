source 'https://rubygems.org'
source 'http://gems.test.mas'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.1.5'

gem 'activerecord-session_store'
gem 'aes'
gem 'cream'
gem 'devise'
gem 'devise-encryptable'
gem 'delayed_job_active_record'
gem 'dough-ruby', '~> 3.0'
gem 'draper', '~> 1.3.0'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'feature', github: 'moneyadviceservice/feature'
gem 'foreman'
gem 'gaffe'
gem 'kramdown'
gem 'kss'
gem 'link_header'
gem 'mail'
gem 'mailjet'
gem 'meta-tags'
gem 'mysql2'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'nunes'
gem 'opening_hours'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'rouge'
gem 'rubytree'
gem 'statsd-ruby'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness'

gem 'budget_planner', '~> 4.0'
gem 'car_cost_tool', '~> 1.0.1'
gem 'debt_advice_locator', '~> 2.0'
gem 'debt_free_day_calculator', '~> 2.0'
gem 'mortgage_calculator', '~> 1.0.0'
gem 'pensions_calculator', '~> 0.2'
gem 'savings_calculator', '~> 1.0.0'

group :assets do
  gem 'autoprefixer-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jshint_ruby'
  gem 'csslint_ruby'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'sass-rails', '~> 4.0.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-rails'
  gem 'guard-rspec', require: false
  gem 'guard-sass'
  gem 'guard-shell'
  gem 'letter_opener'
  gem 'listen', '~> 2.0'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'chronic'
  gem 'codeclimate-test-reporter', require: false
  gem 'email_spec'
  gem 'faker'
  gem 'html_validation'
  gem 'rspec_junit_formatter'
  gem 'sqlite3'
  gem 'tidy-html5', github: 'moneyadviceservice/tidy-html5-gem'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'syslog-logger'
  gem 'unicorn-rails'
end

group :build, :test, :development do
  gem 'bowndler', '~> 1.0'
end

group :test, :development do
  gem 'byebug'
  gem 'chai-jquery-rails'
  gem 'dotenv-rails'
  gem 'ejs'
  gem 'guard-rubocop'
  gem 'mas-development_dependencies', github: 'moneyadviceservice/mas-development_dependencies'
  gem 'rspec-rails', '~> 3.0'
  gem 'rubocop'
end

group :doc do
  gem 'sdoc', require: false
end
