require 'core/repositories/articles/active_resource'
require 'repository_registry'

RepositoryRegistry[:article] =
  Core::Repositories::Articles::ActiveResource.new(ENV['MAS_API_URL'])
