require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'

require 'pry'
require_relative '../config/environment'

require 'rspec/rails'
require 'factory_bot'
require 'html_validation'
require 'webmock/rspec'
require 'database_cleaner'
require 'shoulda-matchers'
require 'timecop'

Time.zone = 'London'
# this seems to be required for the CI to work properly
ENV['TZ'] = 'Europe/London'

DatabaseCleaner.strategy = :deletion

Draper::ViewContext.test_strategy :fast

FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), '..', 'features', 'factories')
FactoryBot.find_definitions

I18n.available_locales = %i[en cy]

PageValidations::HTMLValidation.ignored_attribute_errors = %w[tabindex itemscope itemtype itemprop]
PageValidations::HTMLValidation.ignored_tag_errors       = %w[main svg symbol path polygon use rect]
PageValidations::HTMLValidation.ignored_errors           = ['letter not allowed here']

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'

  c.around_http_request do |request|
    uri = URI(request.uri)

    if ENV['MAS_CMS_URL'] =~ /#{uri.host}/
      VCR.use_cassette("/CMS/#{request.method}#{uri.path}#{uri.query}", &request)
    elsif uri.host =~ /algolia/
      query = JSON.parse(request.body)['params']
      cassette_name = "/algolia/#{request.method}#{uri.path}#{uri.query}/#{query}"
      VCR.use_cassette(cassette_name, match_requests_on: [:body], &request)
    else
      VCR.use_cassette("/#{uri.host}/#{request.method}#{uri.path}#{uri.query}", &request)
    end
  end

  c.filter_sensitive_data('<API_KEY>') { ENV['ALGOLIA_API_KEY'] }
  c.filter_sensitive_data('<APP_ID>') { ENV['ALGOLIA_APP_ID'] }
  c.filter_sensitive_data('<Password>') { ENV['CAR_COST_TOOL_CAP_PASSWORD'] }
end

WebMock.disable_net_connect!(allow: 'codeclimate.com')

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

class FakeFooterRepositoryDefinedInSpecHelper
  def find(_id)
    blocks = %w[
      raw_web_chat_heading raw_web_chat_additional_one raw_web_chat_additional_two
      raw_web_chat_additional_three raw_web_chat_small_print raw_contact_heading
      raw_contact_introduction raw_contact_phone_number raw_contact_additional_one
      raw_contact_additional_two raw_contact_additional_three raw_contact_small_print
    ].map do |identifier|
      { 'identifier' => identifier, 'content' => 'I am some content in a footer' }
    end
    { blocks: blocks }
  end
end

RSpec.configure do |c|
  c.include FactoryBot::Syntax::Methods
  c.include Devise::Test::ControllerHelpers, type: :controller
  c.include PageValidations
  c.include Rails.application.routes.url_helpers
  c.include RSpecHtmlMatchers

  c.infer_base_class_for_anonymous_controllers = false
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'
  c.use_transactional_fixtures = true
  c.order = 'random'
  c.run_all_when_everything_filtered = true

  c.disable_monkey_patching!
  c.example_status_persistence_file_path = 'spec/test_status.txt'

  c.before(:suite) do
    DatabaseCleaner.clean

    Core::Registry::Repository[:customer] = Core::Repository::Customers::Fake.new
  end

  c.before :each do
    I18n.locale = :en
    Core::Registry::Repository[:customer].clear
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
