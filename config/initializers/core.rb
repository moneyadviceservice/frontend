require 'core/connection_factory'
require 'core/registries/connection'
require 'core/registries/repository'
require 'core/repositories/cache'
require 'core/repositories/action_plans/public_website'
require 'core/repositories/articles/public_website'
require 'core/repositories/categories/public_website'
require 'core/repositories/search/google_custom_search_engine'
require 'core/repositories/static_pages/public_website'
require 'core/repositories/news/public_website'

require 'faraday/request/host_header'
require 'faraday/request/x_forwarded_proto'

google_api_connection     = Core::ConnectionFactory.build('https://www.googleapis.com/')
public_website_connection = Core::ConnectionFactory.build(ENV['MAS_PUBLIC_WEBSITE_URL'])

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::HostHeader)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::XForwardedProto)

Core::Registries::Connection[:google_api]     = google_api_connection
Core::Registries::Connection[:public_website] = public_website_connection

Core::Registries::Repository[:action_plan] =
  Core::Repositories::ActionPlans::PublicWebsite.new

Core::Registries::Repository[:article] =
  Core::Repositories::Articles::PublicWebsite.new

Core::Registries::Repository[:category] = Core::Repositories::Cache.new(
  Core::Repositories::Categories::PublicWebsite.new, Rails.cache)

Core::Registries::Repository[:search] =
  Core::Repositories::Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX_EN'], ENV['GOOGLE_API_CX_CY'])

Core::Registries::Repository[:static_page] =
  Core::Repositories::StaticPages::PublicWebsite.new

Core::Registries::Repository[:news] =
  Core::Repositories::News::PublicWebsite.new
