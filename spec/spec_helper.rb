require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'

begin
  require 'pry'
rescue LoadError
end

require_relative '../config/environment'
require 'mas/development_dependencies/rspec/spec_helper'

require 'factory_girl'
require 'feature/testing'
require 'html_validation'
require 'webmock/rspec'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

Draper::ViewContext.test_strategy :fast

FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), '..', 'features', 'factories')
FactoryGirl.find_definitions

I18n.available_locales = [:en, :cy]

PageValidations::HTMLValidation.ignored_attribute_errors = %w(tabindex itemscope itemtype itemprop)
PageValidations::HTMLValidation.ignored_tag_errors       = ['main']
PageValidations::HTMLValidation.ignored_errors           = ['letter not allowed here']

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
end

WebMock.disable_net_connect!(allow: 'codeclimate.com')

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.include PageValidations
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'

  c.disable_monkey_patching!

  c.around(:example, :type => :feature) do |example|
    action_plan_repository = Core::Registry::Repository[:action_plan]
    article_repository     = Core::Registry::Repository[:article]
    category_repository    = Core::Registry::Repository[:category]
    search_repository      = Core::Registry::Repository[:search]

    Core::Registry::Repository[:action_plan] = Core::Repository::VCR.new(action_plan_repository)
    Core::Registry::Repository[:article]     = Core::Repository::VCR.new(article_repository)
    Core::Registry::Repository[:category]    = Core::Repository::VCR.new(category_repository)
    Core::Registry::Repository[:search]      = Core::Repository::VCR.new(search_repository)

    example.run

    Core::Registry::Repository[:action_plan] = action_plan_repository
    Core::Registry::Repository[:article]     = article_repository
    Core::Registry::Repository[:category]    = category_repository
    Core::Registry::Repository[:search]      = search_repository
  end

  c.before(:suite) do
    DatabaseCleaner.clean
    ActiveRecord::Tasks::DatabaseTasks.load_schema(:ruby, ENV['SCHEMA'])
  end
end
