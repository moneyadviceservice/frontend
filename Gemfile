source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# RULES OF THE GEMFILE
#
# 1. Consult contributors before adding a dependency
# 2. Keep dependencies ordered alphabetically
# 3. Place dependencies in the group they belong
# 4. Only use version specifiers where appropriate

gem 'rails', '4.2.7.1'

gem 'activerecord-session_store'
gem 'aes'
gem 'bugsnag'
gem 'cream', '~> 1.0.0'
gem 'delayed_job_active_record'
gem 'devise', '~> 4.2.0'
gem 'devise-encryptable'
gem 'dough-ruby', '~> 5.21.0'
gem 'draper', '< 3'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'feature'
gem 'kss'
gem 'link_header'
gem 'mail'
gem 'mailjet'
gem 'mas-assets', git: 'git@github.com:moneyadviceservice/mas-assets'
gem 'meta-tags', github: 'moneyadviceservice/meta-tags'
gem 'mysql2'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'nunes'
gem 'opening_hours'
gem 'psych', '>= 2.0.5' # https://www.ruby-lang.org/en/news/2014/03/29/heap-overflow-in-yaml-uri-escape-parsing-cve-2014-2525/
gem 'redcarpet'
gem 'rouge'
gem 'rubytree'
gem 'sass-rails'
gem 'statsd-ruby'
gem 'postcode_anywhere-email_validation'
gem 'turnout'

gem 'action_plans', '~> 4.3.0'
gem 'advice_plans', '~> 3.3.1'
gem 'agreements', '~> 2.1.0'
gem 'baby_cost_calculator', '~> 0.3.0'
gem 'budget_planner', '~> 4.5.5'
gem 'car_cost_tool', '~> 1.1.1'
gem 'contribution_calculator', '~> 0.1.0'
gem 'cost_calculator_builder', '~> 0.4.2'
gem 'cutback_calculator', '~> 0.12.0'
gem 'debt_advice_locator', '~> 2.3.1'
gem 'debt_and_mental_health', '~> 1.1.0'
gem 'debt_free_day_calculator', '~> 2.2.1'
gem 'debt_test', '~> 1.6.0'
gem 'decision_trees', '~> 2.1.0'
gem 'feedback', '~> 0.4.0'
gem 'mortgage_calculator', '~> 1.5.2'
gem 'payday_loans_intervention', '~> 1.6.0'
gem 'pensions_calculator', '~> 1.3.1'
gem 'quiz', '~> 1.1.0', source: 'http://gems.dev.mas.local'
gem 'rio', '1.13.0', source: 'http://gems.dev.mas.local'
gem 'savings_calculator', '~> 1.6.0'
gem 'timelines', '~> 1.4.0'

# 1.0.2 has breaking changes as it adds japanese and turkish locales
gem 'validate_url', '1.0.0'

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
  gem 'codeclimate-test-reporter', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec', '< 2' # DelayedJob integration removed in 2.0.0
  gem 'factory_girl'
  gem 'faker'
  gem 'html_validation'
  gem 'poltergeist'
  gem 'rspec_junit_formatter'
  gem 'rspec-html-matchers'
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
