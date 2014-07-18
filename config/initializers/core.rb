require 'core'

require 'faraday/request/host_header'
require 'faraday/request/x_forwarded_proto'

google_api_connection     = Core::ConnectionFactory::Http.build('https://www.googleapis.com/')
public_website_connection = Core::ConnectionFactory::Http.build(ENV['MAS_PUBLIC_WEBSITE_URL'])
internal_email_connection = Core::ConnectionFactory::Smtp.build(from_address: 'Development.Team@moneyadviceservice.org.uk')

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::HostHeader)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::XForwardedProto)

Core::Registry::Connection[:google_api]     = google_api_connection
Core::Registry::Connection[:public_website] = public_website_connection
Core::Registry::Connection[:internal_email] = internal_email_connection

Core::Registry::Repository[:action_plan] =
  Core::Repository::ActionPlans::PublicWebsite.new

Core::Registry::Repository[:article] =
  Core::Repository::Articles::PublicWebsite.new

Core::Registry::Repository[:category] = Core::Repository::Cache.new(
  Core::Repository::Categories::PublicWebsite.new, Rails.cache)

Core::Registry::Repository[:feedback] = Core::Repository::Feedback::Email.new

Core::Registry::Repository[:search] =
  Core::Repository::Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX_EN'], ENV['GOOGLE_API_CX_CY'])

Core::Registry::Repository[:static_page] =
  Core::Repository::StaticPages::PublicWebsite.new

Core::Registry::Repository[:news] =
  Core::Repository::News::PublicWebsite.new

Core::Registry::Repository[:newsletter_subscription] =
  Core::Repository::NewsletterSubscriptions::PublicWebsite.new

# Prepare the category tree so that it is available to the application
Core::CategoryTreeReader.new.call if Rails.env.production? and defined?(Rails::Server)
