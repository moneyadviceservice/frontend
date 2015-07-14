source 'https://rubygems.org'
source 'http://gems.test.mas'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.1.8'

gem 'activerecord-session_store'
gem 'aes'
gem 'cream'
gem 'delayed_job_active_record'
gem 'devise'
gem 'devise-encryptable'
gem 'dough-ruby', '~> 5.0'
gem 'draper', '~> 1.3.0'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'feature', github: 'moneyadviceservice/feature', branch: 'multiple-features'
gem 'foreman'
gem 'gaffe'
gem 'mastalk'
gem 'kss'
gem 'link_header'
gem 'mail'
gem 'mailjet'
gem 'meta-tags', github: 'moneyadviceservice/meta-tags'
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

gem 'action_plans', '~> 4.0.1'
gem 'advice_plans', '~> 3.1.0'
gem 'agreements', '~> 2.0.1'
gem 'baby_cost_calculator'
gem 'budget_planner', '~> 4.0.1.689'
gem 'car_cost_tool', '~> 1.0.4'
gem 'contribution_calculator', '~> 0.0.1'
gem 'cutback_calculator', '~> 0.10'
gem 'debt_advice_locator', '~> 2.0'
gem 'debt_and_mental_health', '~> 1.0.1'
gem 'debt_free_day_calculator', '~> 2.1.0'
gem 'debt_test'
gem 'decision_trees', '~> 2.0.0'
gem 'feedback', '~> 0.3.1'
gem 'mortgage_calculator', '~> 1.3.5'
gem 'payday_loans_intervention', '~> 1.4'
gem 'pensions_calculator', '~> 1.0.0'
gem 'rio', git: 'git@github.com:moneyadviceservice/rio.git'
gem 'savings_calculator', '~> 1.1.0'

gem 'timelines', '>= 1.2.0', git: 'git@github.com:moneyadviceservice/timelines.git'

group :assets do
  gem 'autoprefixer-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'compass-rails'
  gem 'csslint_ruby'
  gem 'jquery-rails'
  gem 'jshint_ruby'
  gem 'sass-rails', '~> 4.0.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'chronic'
  gem 'codeclimate-test-reporter', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'factory_girl'
  gem 'faker'
  gem 'html_validation'
  gem 'poltergeist'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem 'sqlite3'
  gem 'tidy-html5', github: 'moneyadviceservice/tidy-html5-gem'
  gem 'timecop'
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
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rack-livereload'
  gem 'rspec-rails', '~> 3.0'
  gem 'rubocop'
end

group :doc do
  gem 'sdoc', require: false
end
