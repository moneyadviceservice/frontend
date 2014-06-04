require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'

begin
  require 'pry'
rescue LoadError
end

require_relative '../config/environment'
require 'mas/development_dependencies/rspec/spec_helper'

require 'core/repositories/vcr'
require 'factory_girl'
require 'html_validation'
require 'webmock/rspec'

Draper::ViewContext.test_strategy :fast

FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), '..', 'features', 'factories')
FactoryGirl.find_definitions

I18n.available_locales = [:en, :cy]

PageValidations::HTMLValidation.ignored_attribute_errors = %w(tabindex itemscope itemtype itemprop)
PageValidations::HTMLValidation.ignored_tag_errors       = ['main']

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

WebMock.disable_net_connect!(allow: 'codeclimate.com')

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.include PageValidations
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'

  c.disable_monkey_patching!

  c.around(:example, :type => :feature) do |example|
    action_plan_repository = Core::Registries::Repository[:action_plan]
    article_repository     = Core::Registries::Repository[:article]
    category_repository    = Core::Registries::Repository[:category]
    search_repository      = Core::Registries::Repository[:search]

    Core::Registries::Repository[:action_plan] = Core::Repositories::VCR.new(action_plan_repository)
    Core::Registries::Repository[:article]     = Core::Repositories::VCR.new(article_repository)
    Core::Registries::Repository[:category]    = Core::Repositories::VCR.new(category_repository)
    Core::Registries::Repository[:search]      = Core::Repositories::VCR.new(search_repository)

    example.run

    Core::Registries::Repository[:action_plan] = action_plan_repository
    Core::Registries::Repository[:article]     = article_repository
    Core::Registries::Repository[:category]    = category_repository
    Core::Registries::Repository[:search]      = search_repository
  end
end
