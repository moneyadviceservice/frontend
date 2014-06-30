require 'core'

require 'faraday/request/host_header'
require 'faraday/request/x_forwarded_proto'

google_api_connection     = Core::ConnectionFactory.build('https://www.googleapis.com/')
public_website_connection = Core::ConnectionFactory.build(ENV['MAS_PUBLIC_WEBSITE_URL'])

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::HostHeader)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::XForwardedProto)

Core::Registry::Connection[:google_api]     = google_api_connection
Core::Registry::Connection[:public_website] = public_website_connection

Core::Registry::Repository[:action_plan] =
  Core::Repository::ActionPlans::PublicWebsite.new

Core::Registry::Repository[:article] =
  Core::Repository::Articles::PublicWebsite.new

Core::Registry::Repository[:category] = Core::Repository::Cache.new(
  Core::Repository::Categories::PublicWebsite.new, Rails.cache)

Core::Registry::Repository[:search] =
  Core::Repository::Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX_EN'], ENV['GOOGLE_API_CX_CY'])

Core::Registry::Repository[:static_page] =
  Core::Repository::StaticPages::PublicWebsite.new

Core::Registry::Repository[:news] =
  Core::Repository::News::PublicWebsite.new

Core::Registry::Repository[:newsletter_subscriptions] =
  Core::Repository::Newsletter::Subscriptions::PublicWebsite.new
