require 'core/repositories/active_resource'
require 'repository_registry'

RepositoryRegistry[:action_plan] =
  Core::Repositories::ActiveResource.new(ENV['MAS_API_URL'], 'action_plan')

RepositoryRegistry[:article] =
  Core::Repositories::ActiveResource.new(ENV['MAS_API_URL'], 'article')
