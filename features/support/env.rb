ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'mas/development_dependencies/cucumber/env'
require 'core/repositories/categories/fake'
require 'core/repositories/vcr'

I18n.available_locales = [:en, :cy]

action_plan_repository = Core::Registries::Repository[:action_plan]
article_repository     = Core::Registries::Repository[:article]
category_repository    = Core::Registries::Repository[:category]
search_repository      = Core::Registries::Repository[:search]
static_page_repository = Core::Registries::Repository[:static_page]

Core::Registries::Repository[:action_plan] = Core::Repositories::VCR.new(action_plan_repository)
Core::Registries::Repository[:article]     = Core::Repositories::VCR.new(article_repository)
Core::Registries::Repository[:category]    = Core::Repositories::VCR.new(category_repository)
Core::Registries::Repository[:search]      = Core::Repositories::VCR.new(search_repository)
Core::Registries::Repository[:static_page] = Core::Repositories::VCR.new(static_page_repository)

Before('@fake-articles') do
  @real_article_repository = Core::Registries::Repository[:article]
end

After('@fake-articles') do
  Core::Registries::Repository[:article] = @real_article_repository
end
