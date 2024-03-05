ruby IO.read('.ruby-version').strip

source 'https://rubygems.org'
source 'https://gem.fury.io/h_app288206558'

# force Bundler to use SSL
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

source "https://gems.railslts.com" do
  gem 'rails', '~> 4.2.11'
  gem 'actionmailer',     require: false
  gem 'actionpack',       require: false
  gem 'activemodel',      require: false
  gem 'activerecord',     require: false
  gem 'activesupport',    require: false
  gem 'railties',         require: false
  gem 'actionview',       require: false
  gem 'activejob',        require: false
  gem 'railslts-version', require: false
end

gem 'activerecord-session_store'

##############################################################
# The aes gem is no longer supported, so point to the repo that
# resolves deprecation warnings in Ruby's OpenSSL module.
#
# This could feasibly be replaced by an implementation within
# this repo, as all the gem is doing is wrapping OpenSSL.
##############################################################
gem 'aes', github: 'chicks/aes'
gem 'algoliasearch'
gem 'attr_encrypted', '~> 3.1'
gem 'blind_index', '0.2.0'
gem 'delayed_job_active_record'
gem 'devise', '~> 4.7.1'
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
gem 'mysql2'
gem 'nokogiri'
gem 'nunes'
gem 'opening_hours'
gem 'rollbar'
gem 'postcode_anywhere-email_validation', :source => 'https://gem.fury.io/h_app288206558'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'rack', github: 'rails-lts/rack', branch: 'lts-1-6-stable'
gem 'rack-rewrite'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'redcarpet'
gem 'rest-client', '~> 2.0'
gem 'rouge'
gem 'rubytree', '~> 1'
gem 'sass-rails'
gem 'statsd-ruby'
gem 'sucker_punch'
gem 'turnout'
gem 'whenever', require: false
gem 'websocket-extensions', '>= 0.1.5'

# MAS Gems
# ========
# Dependencies
gem 'adal', github: 'moneyadviceservice/azure-activedirectory-library-for-ruby'
gem 'cream', '2.1.8'
gem 'dough-ruby', github: 'moneyadviceservice/dough', branch: 'PostMessages_v5.45'
gem 'mas-cms-client', '1.20.1'
gem 'site_search', '0.3.0'
# Tools
gem 'action_plans', github: 'moneyadviceservice/action_plans', ref: '3676931'
gem 'advice_plans', '~> 4.1.1'
gem 'agreements', '~> 2.5.0'
gem 'budget_planner', github: 'moneyadviceservice/budget_planner', ref: '0efd1a9'
gem 'cost_calculator_builder', github: 'moneyadviceservice/cost_calculator_builder', ref: '768b202'
gem 'cutback_calculator', '~> 0.13.0'
gem 'debt_advice_locator', '~> 4.2.0'
gem 'debt_and_mental_health', '~> 1.6.0'
gem 'debt_free_day_calculator', github: 'moneyadviceservice/debt_free_day_calculator', ref: '531f573'
gem 'debt_test', '~> 1.9.0'
gem 'decision_trees', '~> 2.3.0'
gem 'feedback', '~> 0.5.1'
gem 'lograge'
gem 'mortgage_calculator', '~> 4.6.0'
gem 'pacs', '~> 4.2'
gem 'payday_loans_intervention', '~> 1.9.0'
gem 'pensions_calculator', github: 'moneyadviceservice/pensions_calculator', ref: 'baceac3'
gem 'puma'
gem 'quiz', '~> 1.4.0', source: 'https://gem.fury.io/h_app288206558'
gem 'savings_calculator', github: 'moneyadviceservice/savings_calculator', ref: '1ccfd87'
gem 'timelines', '~> 2.2.1'
gem 'universal_credit', github: 'moneyadviceservice/universal_credit', ref: '5d330f3'
gem 'wpcc', github: 'moneyadviceservice/wpcc', ref: '30b2c2e'

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
  gem 'net-http'
  gem 'net-smtp'
  gem 'net-imap'
  gem 'rspec-html-matchers'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem 'sqlite3', '1.4.2'
  gem 'tidy-html5'
  gem 'timecop'
  gem 'uri', '0.10.0'
  gem 'vcr'
  gem 'warning', '~> 1.3'
  gem 'webmock', '~> 3.5.0'
end

group :production do
  gem 'syslog-logger'
  gem 'rails_12factor'
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
