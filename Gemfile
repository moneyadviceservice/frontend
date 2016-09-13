source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.1.8'

gem 'activerecord-session_store'
gem 'aes'
gem 'bugsnag'
gem 'cream', '~> 0.3.0'
gem 'delayed_job_active_record'
gem 'devise', '3.2.4'
gem 'devise-encryptable'
gem 'dough-ruby', '~> 5.19.0'
gem 'draper', '< 3'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'feature'
gem 'foreman'
gem 'kss'
gem 'link_header'
gem 'mail'
gem 'mailjet'
gem 'mas-assets', git: 'git@github.com:moneyadviceservice/mas-assets'
gem 'meta-tags', github: 'moneyadviceservice/meta-tags'
gem 'mysql2', '0.3.20'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'nunes'
gem 'opening_hours'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'redcarpet'
gem 'rouge'
gem 'rubytree'
gem 'statsd-ruby'
gem 'uglifier', '>= 1.3.0'
gem 'postcode_anywhere-email_validation'

gem 'action_plans', '~> 4.2.8'
gem 'advice_plans', '~> 3.2.0'
gem 'agreements', '~> 2.1.0'
gem 'baby_cost_calculator', '~> 0.3.0'
gem 'budget_planner', '~> 4.2.0'
gem 'car_cost_tool', '~> 1.1.0'
gem 'contribution_calculator', '~> 0.0.1'
gem 'cost_calculator_builder', '~> 0.2.0'
gem 'cutback_calculator', '~> 0.11.0'
gem 'debt_advice_locator', '~> 2.3.0'
gem 'debt_and_mental_health', '~> 1.1.0'
gem 'debt_free_day_calculator', '~> 2.2.0'
gem 'debt_test', '~> 1.5.0'
gem 'decision_trees', '~> 2.0.0'
gem 'feedback', '~> 0.4.0'
gem 'mortgage_calculator', '~> 1.5.0'
gem 'payday_loans_intervention', '~> 1.4'
gem 'pensions_calculator', '~> 1.2.0'
gem 'quiz', '~> 1.1.0'
gem 'rio', '1.6.0', source: 'http://gems.dev.mas.local'
gem 'savings_calculator', '~> 1.5.0'
gem 'timelines', '~> 1.3.0'

# 1.0.2 has breaking changes as it adds japanese and turkish locales
gem 'validate_url', '1.0.0'

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
  gem 'rspec-html-matchers'
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
