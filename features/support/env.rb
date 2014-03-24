ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'mas/development_dependencies/cucumber/env'
require 'core/repositories/categories/fake'

I18n.available_locales = [:en, :cy]

Core::Registries::Repository[:category] = Core::Repositories::Categories::Fake.new

Capybara.default_wait_time = 5
