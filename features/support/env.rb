ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path('../../../', __FILE__)

require 'mas/development_dependencies/cucumber/env'
require 'feature/testing'

I18n.available_locales = [:en, :cy]

action_plan_repository             = Core::Registry::Repository[:action_plan]
article_repository                 = Core::Registry::Repository[:article]
category_repository                = Core::Registry::Repository[:category]
search_repository                  = Core::Registry::Repository[:search]
static_page_repository             = Core::Registry::Repository[:static_page]
news_article_repository            = Core::Registry::Repository[:news]
newsletter_subscription_repository = Core::Registry::Repository[:newsletter_subscription]

Core::Registry::Repository[:action_plan]             = Core::Repository::VCR.new(action_plan_repository)
Core::Registry::Repository[:article]                 = Core::Repository::VCR.new(article_repository)
Core::Registry::Repository[:category]                = Core::Repository::VCR.new(category_repository)
Core::Registry::Repository[:search]                  = Core::Repository::VCR.new(search_repository)
Core::Registry::Repository[:static_page]             = Core::Repository::VCR.new(static_page_repository)
Core::Registry::Repository[:news]                    = Core::Repository::VCR.new(news_article_repository)
Core::Registry::Repository[:newsletter_subscription] = Core::Repository::VCR.new(newsletter_subscription_repository)

Around('@fake-articles') do |scenario, block|
  @real_article_repository = Core::Registry::Repository[:article]
  block.call
  Core::Registry::Repository[:article] = @real_article_repository
end

Around do |scenario, block|
  enable_feature_tag = /^@enable-/
  enable_tags        = scenario.source_tag_names.grep(enable_feature_tag)
  enable_feature     = if enable_tags.size > 1
                         fail StandardError.new('Only singular feature tags are supported')
                       elsif enable_tags.size > 0
                         enable_tags.first.gsub(enable_feature_tag, '').underscore.to_sym
                       end

  if enable_feature
    Feature.run_with_activated(enable_feature) do
      Rails.application.reload_routes!
      block.call
    end
    Rails.application.reload_routes!
  else
    block.call
  end

  Timecop.return
end

['@enable-sign-in', '@enable-registration'].each do |tag|
  Around(tag) do |scenario, block|
    Feature.run_with_activated(:sign_in) do
      Devise.regenerate_helpers!
      Devise.class_variable_set(:@@warden_configured, false)
      Devise.configure_warden!

      block.call
    end

    Devise.regenerate_helpers!
    Devise.class_variable_set(:@@warden_configured, false)
    Devise.configure_warden!
  end
end

AfterConfiguration do
  DatabaseCleaner.clean
  ActiveRecord::Tasks::DatabaseTasks.load_schema(:ruby, ENV['SCHEMA'])
end

Capybara.default_wait_time = 20
