require 'core/connection_factory'
require 'core/registries/connection'
require 'core/registries/repository'
require 'core/repositories/repository_cache'
require 'core/repositories/action_plans/public_website'
require 'core/repositories/articles/public_website'
require 'core/repositories/categories/public_website'
require 'core/repositories/search/content_service'
require 'core/repositories/search/google_custom_search_engine'

require 'faraday/request/host_header'
require 'faraday/request/x_forwarded_proto'

content_service_connection = Core::ConnectionFactory.build(ENV['MAS_CONTENT_SERVICE_URL'])
google_api_connection      = Core::ConnectionFactory.build(ENV['GOOGLE_API_URL'])
public_website_connection  = Core::ConnectionFactory.build(ENV['MAS_PUBLIC_WEBSITE_URL'])

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::HostHeader)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::XForwardedProto)

Core::Registries::Connection[:google_api]      = google_api_connection
Core::Registries::Connection[:content_service] = content_service_connection
Core::Registries::Connection[:public_website]  = public_website_connection

Core::Registries::Repository[:action_plan] =
  Core::Repositories::ActionPlans::PublicWebsite.new

Core::Registries::Repository[:article] =
  Core::Repositories::Articles::PublicWebsite.new

Core::Registries::Repository[:category] = Core::RepositoryCache.new(
  Core::Repositories::Categories::PublicWebsite.new)

if Rails.env.production?
  Core::Registries::Repository[:search] =
    Core::Repositories::Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX_EN'], ENV['GOOGLE_API_CX_CY'])
else
  Core::Registries::Repository[:search] =
    Core::Repositories::Search::ContentService.new
end
