require 'core/registries/repository'
require 'core/repositories/action_plans/public_website'
require 'core/repositories/articles/public_website'

public_website_url = ENV['MAS_PUBLIC_WEBSITE_URL']

Core::Registries::Repository[:action_plan] =
  Core::Repositories::ActionPlans::PublicWebsite.new(public_website_url)

Core::Registries::Repository[:article] =
  Core::Repositories::Articles::PublicWebsite.new(public_website_url)
