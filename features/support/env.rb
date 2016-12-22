ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'cucumber/rails'
require 'cucumber/rspec/doubles'
require 'capybara'
require 'capybara/poltergeist'
require 'site_prism'
require 'timecop'
require 'feature/testing'
require 'email_spec/cucumber'

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
  ActiveRecord::Tasks::DatabaseTasks.load_schema(:ruby, ENV['SCHEMA'])

  Core::Registry::Repository[:customer] = Core::Repository::Customers::Fake.new
end

Before do
  Core::Registry::Repository[:customer].clear
end

Before('@export-corporate-partners') do
  create(:corporate_partner)
end

Before('@auth-required') do
  @username = 'admin'
  @password = 'password'
  allow(Authenticable).to receive(:username)  { @username }
  allow(Authenticable).to receive(:password)  { @password }
  allow(Authenticable).to receive(:required?) { true }
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 20
