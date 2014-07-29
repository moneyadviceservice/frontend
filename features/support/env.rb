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
  enable_tag = scenario.scenario_tags.detect{|tag| tag.name =~ /@enable-.*/} if scenario.respond_to?(:scenario_tags)
  enable_feature = enable_tag.name.gsub('@enable-','').gsub('-','_').to_sym if enable_tag

  if enable_feature
    Feature.run_with_activated(enable_feature) do
      block.call
    end
  else
    block.call
  end
end

Capybara.default_wait_time = 20
