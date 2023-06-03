ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'cucumber/rails'
require 'cucumber/rspec/doubles'
require 'capybara'
require 'site_prism'
require 'timecop'
require 'email_spec/cucumber'
require 'selenium/webdriver'
require 'webdrivers/chromedriver'


I18n.available_locales = [:en, :cy]
Time.zone = 'London'

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy                      = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

Core::Registry::Repository[:customer] = Core::Repository::Customers::Fake.new

Around('@fake-articles') do |_scenario, block|
  @real_article_repository = Core::Registry::Repository[:article]
  block.call
  Core::Registry::Repository[:article] = @real_article_repository
end

Around do |scenario, block|
  enabled_feature_tag = /^@enable-/
  enabled_tags     = scenario.source_tag_names.grep(enabled_feature_tag)
  enabled_features = enabled_tags.map { |t| t.gsub(enabled_feature_tag, '').underscore.to_sym }

  if enabled_features.empty?
    block.call
  else
    Feature.run_with_activated(*enabled_features) do
      Rails.application.reload_routes!
      block.call
    end
    Rails.application.reload_routes!
  end
end

AfterConfiguration do
  DatabaseCleaner.clean

  Core::Registry::Repository[:customer] = Core::Repository::Customers::Fake.new
end

Before do
  Core::Registry::Repository[:customer].clear
end

Before('@export-corporate-partners') do
  create(:corporate_partner)
end

Before('@allow_rescue') do
  ActionController::Base.allow_rescue = true
end

Before('@auth-required') do
  @username = 'admin'
  @password = 'password'
  allow(Authenticable).to receive(:username)  { @username }
  allow(Authenticable).to receive(:password)  { @password }
  allow(Authenticable).to receive(:required?) { true }
end


Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w(headless no-sandbox disable-gpu window-size=2500,2500)
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless
Capybara.default_max_wait_time = 20
