source 'https://rubygems.org'

gem 'rails', '4.1.0.rc1'

gem 'draper', '~> 1.3.0'
gem 'faraday_middleware'
gem 'foreman'
gem 'gaffe'
gem 'kss'
gem 'link_header'
gem 'meta-tags', require: 'meta_tags'
gem 'nokogiri'
gem 'rouge'

group :assets do
  gem 'autoprefixer-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
end

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
  gem 'mas-development_dependencies',
      git: 'https://github.com/moneyadviceservice/mas-development_dependencies.git'
  gem 'chai-jquery-rails'
end

group :doc do
  gem 'sdoc', require: false
end
