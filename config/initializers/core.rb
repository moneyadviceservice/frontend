require 'core/connection_factory'
require 'core/registries/connection'
require 'core/registries/repository'
require 'core/repositories/action_plans/public_website'
require 'core/repositories/articles/public_website'
require 'core/repositories/categories/public_website'
require 'core/repositories/search/public_website'

Core::Registries::Connection[:public_website] =
  Core::ConnectionFactory.build(ENV['MAS_PUBLIC_WEBSITE_URL'])

Core::Registries::Repository[:action_plan] =
  Core::Repositories::ActionPlans::PublicWebsite.new

Core::Registries::Repository[:article] =
  Core::Repositories::Articles::PublicWebsite.new

Core::Registries::Repository[:category] =
  Core::Repositories::Categories::PublicWebsite.new

Core::Registries::Repository[:search] =
  Core::Repositories::Search::PublicWebsite.new
