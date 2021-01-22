source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

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
gem 'aes', git: 'git@github.com:chicks/aes.git'
gem 'algoliasearch'
gem 'attr_encrypted', '~> 3.1'
gem 'blind_index', '0.2.0'
gem 'bugsnag'
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
gem 'mysql2', '0.4.9'
gem 'newrelic_rpm'
gem 'nokogiri', '~> 1.10.3'
gem 'nunes'
gem 'opening_hours'
gem 'postcode_anywhere-email_validation', '~> 0.2.0'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'rack', git: 'https://github.com/rails-lts/rack.git', branch: 'lts-1-6-stable'
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
gem 'adal', git: 'git@github.com:moneyadviceservice/azure-activedirectory-library-for-ruby'
gem 'cream', '2.1.8'
gem 'dough-ruby', git: 'git@github.com:moneyadviceservice/dough.git', branch: '11691_DAL_Current-location-warning-message_v5.41', ref: 'a90d79d'
gem 'mas-cms-client', '1.20.1'
gem 'site_search', '0.3.0'
# Tools


# gem 'action_plans', '~> 5.5.0' 
# action_plans - update to date and ahead of master as of 21/1/2021
gem 'action_plans', git: 'git@github.com:moneyadviceservice/action_plans.git', branch: 'feature/ntt_moneyhelper_reskin'


gem 'advice_plans', '~> 4.1.1'
gem 'agreements', '~> 2.5.0'

# gem 'budget_planner', '~> 5.7.1'
# budget_planner - update to date and ahead of master as of 21/1/2021
gem 'budget_planner', git: 'git@github.com:moneyadviceservice/budget_planner.git', branch: 'preview'


# gem 'car_cost_tool', '~> 1.5'
# car_cost_tool - update to date and ahead of master as of 21/1/2021 - renaming branch merged with some incorrect naming
gem 'car_cost_tool', git: 'git@github.com:moneyadviceservice/car_cost_tool.git', branch: 'feature/ntt_moneyhelper_reskin'


# gem 'cost_calculator_builder', '~> 1.1.0'
# cost_calculator_builder - update to date and ahead of master as of 21/1/2021 - no domain renaming branch found
gem 'cost_calculator_builder', git: 'git@github.com:moneyadviceservice/cost_calculator_builder.git', branch: 'feature/ntt_moneyhelper_reskin'


gem 'cutback_calculator', '~> 0.13.0'


# gem 'debt_advice_locator', '3.13.0'
# debt_advice_locator - update to date and ahead of master as of 21/1/2021
gem 'debt_advice_locator', git: 'git@github.com:moneyadviceservice/debt-advice-locator.git', branch: 'feature/ntt_moneyhelper_reskin'


gem 'debt_and_mental_health', '~> 1.6.0'


# gem 'debt_free_day_calculator', git: 'git@github.com:moneyadviceservice/debt_free_day_calculator', branch: '11920_Storage-Access-API'
# debt_advice_locator - update to date and ahead of master as of 21/1/2021 - no domain renaming branch found
gem 'debt_free_day_calculator', git: 'git@github.com:moneyadviceservice/debt_free_day_calculator', branch: 'feature/ntt_moneyhelper_reskin'


gem 'debt_test', '~> 1.9.0'
gem 'decision_trees', '~> 2.3.0'
gem 'feedback', '~> 0.5.1'


# gem 'mortgage_calculator', '~> 3.17.0'
# debt_advice_locator - update to date and ahead of master as of 21/1/2021 - renaming branch merged
gem 'mortgage_calculator', git: 'git@github.com:moneyadviceservice/mortgage_calculator.git', branch: 'feature/ntt_moneyhelper_reskin'



# gem 'pacs', '~> 3.13.0'
# pacs - behind master as of 21/1/2021 forked at 01438080c8eeccd31c2ff47f9b75537abca1512d - renaming branch found and merged
gem 'pacs', git: 'git@github.com:moneyadviceservice/pacs.git', branch: 'feature/ntt_moneyhelper_reskin'



gem 'payday_loans_intervention', '~> 1.9.0'



# gem 'pensions_calculator', '~> 2.7.1'
# pensions_calculator - behind master as of 21/1/2021 forked at 30dc12b9b83d99071244cd04c8f27fcb688a52b2 (NTT from 3b82283f17368c8bcf3425ad20778c746dcb2286) - renaming branch found and merged
gem 'pensions_calculator', git: 'git@github.com:moneyadviceservice/pensions_calculator.git', branch: 'feature/ntt_moneyhelper_reskin'



gem 'quiz', '~> 1.4.0', source: 'http://gems.dev.mas.local'
gem 'rio', '~> 2.2.1', source: 'http://gems.dev.mas.local'


# gem 'savings_calculator', '~> 1.10.2'
# savings_calculator - update to date and ahead of master as of 19/1/2021 - renaming branch merged with some incorrect naming
gem 'savings_calculator', git: 'git@github.com:moneyadviceservice/savings_calculator.git', branch: 'feature/ntt_moneyhelper_reskin'


# gem 'timelines', '~> 1.7.1'
# timelines - update to date and ahead of master as of 19/1/2021 - no domain renaming branch found
gem 'timelines', git: 'git@github.com:moneyadviceservice/timelines.git', branch: 'feature/ntt_moneyhelper_reskin'


# gem 'universal_credit', '~> 4.1.1'
# timelines - update to date and ahead of master as of 21/1/2021 - no domain renaming branch found
gem 'universal_credit', git: 'git@github.com:moneyadviceservice/universal_credit.git', branch: 'feature/ntt_moneyhelper_reskin'


# gem 'wpcc', '2.8.3'
# wpcc - update to date and ahead of master as of 21/1/2021 - renaming branch merged
gem 'wpcc', git: 'git@github.com:moneyadviceservice/wpcc.git', branch: 'feature/ntt_moneyhelper_reskin'


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
  gem 'cucumber-rails', '~> 2.1.0', require: false
  gem 'database_cleaner'
  gem 'email_spec', '< 2' # DelayedJob integration removed in 2.0.0
  gem 'factory_bot', '~> 4.10.0'
  gem 'faker'
  gem 'html_validation'
  gem 'poltergeist'
  gem 'rspec-html-matchers'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov', '~>0.16.1'
  gem 'site_prism'
  gem 'sqlite3', '~> 1.3.6'
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
