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
gem 'devise', '~> 4.6.0'
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
gem 'cream', '2.1.7'
gem 'dough-ruby', '~> 5.36'
gem 'mas-cms-client', '1.20.0'
gem 'site_search', '0.3.0'
# Tools
gem 'action_plans', git: 'git@github.com:moneyadviceservice/action_plans.git', branch: '10228_Update-JQuery'
gem 'advice_plans', git: 'git@github.com:moneyadviceservice/advice_plans.git', branch: '10229-jquery-upgrade'
gem 'agreements', git: 'git@github.com:moneyadviceservice/agreements.git', branch: '10230-update-jquery'
gem 'budget_planner', git: 'git@github.com:moneyadviceservice/budget_planner.git', branch: '10232_Update-JQuery'
gem 'car_cost_tool', '~> 1.5'
gem 'cost_calculator_builder', git: 'git@github.com:moneyadviceservice/cost_calculator_builder.git', branch: '9756-jquery-upgrade'
gem 'cutback_calculator', '~> 0.13.0'
gem 'debt_advice_locator', '~> 3.4.0'
gem 'debt_and_mental_health', git: 'git@github.com:moneyadviceservice/debt_and_mental_health.git', branch: '10236_update-jquery'
gem 'debt_free_day_calculator', '~> 3.1.0'
gem 'debt_test', git: 'git@github.com:moneyadviceservice/debt_test.git', branch: '10238-jquery-3'
gem 'decision_trees', git: 'git@github.com:moneyadviceservice/decision_trees.git', branch: '10239-update-jquery'
gem 'feedback', '~> 0.5.1'
gem 'mortgage_calculator', '~> 3.8.0'
gem 'pacs', '3.5.3'
gem 'payday_loans_intervention', git: 'git@github.com:moneyadviceservice/payday_loans_intervention.git', branch: '10243-jquery-3'
gem 'pensions_calculator', '~> 2.5.0'
gem 'quiz', git: 'git@github.com:moneyadviceservice/quiz.git', branch: '10245-update-jquery'
gem 'rio', git: 'git@github.com:moneyadviceservice/rio.git', branch: '10396_update-jquery-part2', ref: 'cd2b365'
gem 'savings_calculator', git: 'git@github.com:moneyadviceservice/savings_calculator.git' , branch: '10396_update-jquery-part2', ref: '99f3de8'
gem 'timelines', '~> 1.5.0'
gem 'universal_credit', '4.0.0'
gem 'wpcc', '2.5.0'

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
