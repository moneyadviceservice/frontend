source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.2.11'

gem 'activerecord-session_store'
gem 'aes'
gem 'algoliasearch'
gem 'attr_encrypted', '~> 3.1'
gem 'blind_index', '0.2.0'
gem 'bugsnag'
gem 'delayed_job_active_record'
gem 'devise', '~> 4.2.0'
gem 'devise-encryptable'
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
gem 'nokogiri', '>= 1.8.5'
gem 'nunes'
gem 'opening_hours'
gem 'postcode_anywhere-email_validation'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'recaptcha', require: 'recaptcha/rails'
gem 'redcarpet'
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
gem 'cream', '2.1.7'
gem 'dough-ruby', '~> 5.29'
gem 'mas-assets', git: 'git@github.com:moneyadviceservice/mas-assets'
gem 'mas-cms-client', '1.19.0'
gem 'site_search', git: 'git@github.com:moneyadviceservice/site_search.git'
# Tools
gem 'action_plans', '~> 5.0.0'
gem 'advice_plans', '~> 3.3.1'
gem 'agreements', '~> 2.3.0'
gem 'baby_cost_calculator', '~> 0.3.0'
gem 'budget_planner', '~> 5.3.0'
gem 'car_cost_tool', '~> 1.3'
gem 'cost_calculator_builder', '~> 0.4.6'
# gem 'cutback_calculator', '~> 0.12.0'
gem 'cutback_calculator', git: 'git@github.com:moneyadviceservice/cutback-calculator.git', branch: '10118-upgrade-ruby2.5.3', ref: '72a458f0480212024016944ad37a234182a6cd43'
gem 'debt_advice_locator', '~> 3.0.0'
gem 'debt_and_mental_health', '~> 1.3.1'
gem 'debt_free_day_calculator', '~> 2.4.0'
gem 'debt_test', '~> 1.7.3'
gem 'decision_trees', '~> 2.1.0'
gem 'feedback', '~> 0.4.0'
gem 'mortgage_calculator', '~> 3.3.0'
gem 'pacs', '3.1.2'
gem 'payday_loans_intervention', '~> 1.7.0'
gem 'pensions_calculator', '~> 2.0.0'
gem 'quiz', '~> 1.2.0', source: 'http://gems.dev.mas.local'
gem 'rio', '~> 2.0.0', source: 'http://gems.dev.mas.local'
gem 'savings_calculator', '~> 1.8.1'
gem 'timelines', '~> 1.5.0'
gem 'universal_credit', '3.1.0'
gem 'wpcc', '2.1.1'

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
  gem 'bowndler', '~> 1.0'
end

group :test, :development do
  gem 'byebug'
  gem 'chai-jquery-rails'
  gem 'dotenv-rails'
  gem 'ejs'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rack-livereload'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :doc do
  gem 'sdoc', require: false
end
