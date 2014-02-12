require 'core/repositories/api'
require 'repository_registry'

RepositoryRegistry[:action_plan] =
  Core::Repositories::API.new(ENV['MAS_API_URL'], 'action_plan')

RepositoryRegistry[:article] =
  Core::Repositories::API.new(ENV['MAS_API_URL'], 'article')
