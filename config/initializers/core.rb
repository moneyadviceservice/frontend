require 'core/repositories/articles/api'
require 'repository_registry'

RepositoryRegistry[:article] =
  Core::Repositories::Articles::API.new(ENV['MAS_API_URL'])
