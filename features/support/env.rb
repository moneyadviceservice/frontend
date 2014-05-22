ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'mas/development_dependencies/cucumber/env'
require 'core/repositories/categories/fake'

I18n.available_locales = [:en, :cy]

Core::Registries::Repository[:category] = Core::Repositories::Categories::Fake.new

Before('@fake-articles') do
  @real_article_repository = Core::Registries::Repository[:article]
end

After('@fake-articles') do
  Core::Registries::Repository[:article] = @real_article_repository
end
