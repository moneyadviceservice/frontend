source 'https://rubygems.org'

gem 'rails', '4.1.0.rc1'

gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'compass-rails'
gem 'draper', '~> 1.3.0'
gem 'faraday_middleware'
gem 'foreman'
gem 'gaffe'
gem 'jquery-rails'
gem 'kss'
gem 'link_header'
gem 'meta-tags', require: 'meta_tags'
gem 'nokogiri'
gem 'rouge'
gem 'sass-rails', '~> 4.0.0'
gem 'syslog-logger'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn-rails'

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
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'thin'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'syslog-logger'
  gem 'unicorn-rails'
end

group :test, :development do
  gem 'ejs'
  gem 'dotenv-rails'
  gem 'mas-development_dependencies', github: 'moneyadviceservice/mas-development_dependencies'
end

group :doc do
  gem 'sdoc', require: false
end
