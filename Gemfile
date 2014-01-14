source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '4.1.0.beta1'

gem 'coffee-rails', '~> 4.0.0'
gem 'draper', '~> 1.3.0'
gem 'foreman'
gem 'jquery-rails'
gem 'kss'
gem 'rouge'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn-rails'
gem 'autoprefixer-rails'

group :test do
  gem 'spring'
end

group :test, :development do
  gem 'mas-development_dependencies',
      git:     'git@github.com:moneyadviceservice/mas-development_dependencies.git',
      require: 'mas/development_dependencies/konacha'
end

group :doc do
  gem 'sdoc', require: false
end
