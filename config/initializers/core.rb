require 'core/repositories/action_plans/public_website'
require 'core/repositories/articles/public_website'
require 'repository_registry'

public_website_url = ENV['MAS_PUBLIC_WEBSITE_URL']

RepositoryRegistry[:action_plan] =
  Core::Repositories::ActionPlans::PublicWebsite.new(public_website_url)

RepositoryRegistry[:article] =
  Core::Repositories::Articles::PublicWebsite.new(public_website_url)
