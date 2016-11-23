require 'core'

require 'faraday/request/host_header'
require 'faraday/request/x_forwarded_proto'

require Rails.root.join('config/initializers/feature')

google_api_connection     = Core::ConnectionFactory::Http.build('https://www.googleapis.com/')
public_website_connection = Core::ConnectionFactory::Http.build(ENV['MAS_PUBLIC_WEBSITE_URL'])
internal_email_connection = Core::ConnectionFactory::Smtp.build(from_address: 'development.team@moneyadviceservice.org.uk')
cms_connection            = Core::ConnectionFactory::Http.build(ENV['MAS_CMS_URL'], retries: 0)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::HostHeader)

public_website_connection.builder.insert_after(Faraday::Request::RequestId,
                                               Faraday::Request::XForwardedProto)

Core::Registry::Connection[:google_api]     = google_api_connection
Core::Registry::Connection[:public_website] = public_website_connection
Core::Registry::Connection[:internal_email] = internal_email_connection
Core::Registry::Connection[:cms]            = cms_connection

Core::Registry::Repository[:action_plan] =
  Core::Repository::ActionPlans::CMS.new

Core::Registry::Repository[:article] =
  Core::Repository::Articles::CMS.new

Core::Registry::Repository[:cms_api] =
  Core::Repository::CMS::CmsApi.new

Core::Registry::Repository[:page_feedback] =
  Core::Repository::CMS::PageFeedback.new

Core::Registry::Repository[:footer] =
  Core::Repository::Cache.new(Core::Repository::Footer::CMS.new, Rails.cache)

Core::Registry::Repository[:home_page] =
  Core::Repository::HomePages::CMS.new

Core::Registry::Repository[:video] =
  Core::Repository::Videos::CMS.new

Core::Registry::Repository[:corporate] =
  Core::Repository::Corporate::CMS.new

Core::Registry::Repository[:category] = Core::Repository::Cache.new(Core::Repository::Categories::CMS.new, Rails.cache)

Core::Registry::Repository[:feedback] = Core::Repository::Feedback::Email.new

Core::Registry::Repository[:search] =
  Core::Repository::Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX_EN'], ENV['GOOGLE_API_CX_CY'])

Core::Registry::Repository[:static_page] =
  Core::Repository::StaticPages::Cms.new

Core::Registry::Repository[:news] =
  Core::Repository::News::PublicWebsite.new

Core::Registry::Repository[:news_article] =
  Core::Repository::News::CMS.new

if Rails.env.development?
  Core::Registry::Repository[:customer] =
    Core::Repository::Customers::Fake.new
else
  Core::Registry::Repository[:customer] =
    Core::Repository::Customers::Cream.new
end

Core::Registry::Repository[:user] =
  Core::Repository::Users::Default.new

# Prepare the category tree so that it is available to the application
Core::CategoryTreeReader.new.call if Rails.env.production? and defined?(Rails::Server)

Core::Registry::Repository[:preview] =
  Core::Repository::CMS::Preview.new

Core::Registry::Repository[:recommended_tool_class] =
  Core::Repository::RecommendedTools::Static

Core::Registry::Repository[:saved_tools] = Core::Repository::SavedTools::Static
