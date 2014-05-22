require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'

begin
  require 'pry'
rescue LoadError
end

require_relative '../config/environment'
require 'mas/development_dependencies/rspec/spec_helper'
require 'webmock/rspec'
require 'factory_girl'
require 'html_validation'
require 'core/repositories/categories/fake'

Core::Registries::Repository[:category] = Core::Repositories::Categories::Fake.new

I18n.available_locales = [:en, :cy]

Draper::ViewContext.test_strategy :fast

FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), '..', 'features', 'factories')
FactoryGirl.find_definitions

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.include PageValidations
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'

  c.disable_monkey_patching!
end

WebMock.disable_net_connect!(allow: 'codeclimate.com')

PageValidations::HTMLValidation.ignored_attribute_errors = ['tabindex']
PageValidations::HTMLValidation.ignored_tag_errors       = ['main']
