require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'

begin
  require 'pry'
rescue LoadError
end

require_relative '../config/environment'

require 'rspec/rails'
require 'factory_girl'
require 'feature/testing'
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

FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), '..', 'features', 'factories')
FactoryGirl.find_definitions

I18n.available_locales = [:en, :cy]

PageValidations::HTMLValidation.ignored_attribute_errors = %w(tabindex itemscope itemtype itemprop)
PageValidations::HTMLValidation.ignored_tag_errors       = %w(main svg symbol path polygon use rect)
PageValidations::HTMLValidation.ignored_errors           = ['letter not allowed here']

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'

  c.around_http_request do |request|
    uri = URI(request.uri)

    if ENV['MAS_CMS_URL'] =~ /#{uri.host}/
      VCR.use_cassette("/CMS/#{request.method}#{uri.path}#{uri.query}", &request)

    # Sanitize the params when using to build the filename
    elsif uri.host =~ /googleapis.com/
      params = CGI.parse(uri.query)
      params['key'] = ['GOOGLE_API_KEY']
      params['cx'].first.gsub!(/#{ENV['GOOGLE_API_CX_EN']}/, 'GOOGLE_API_CX_EN')
      params['cx'].first.gsub!(/#{ENV['GOOGLE_API_CX_CY']}/, 'GOOGLE_API_CX_CY')

      VCR.use_cassette("/GOOGLE_SEARCH/#{request.method}/#{params.to_query}", &request)

    else
      VCR.use_cassette("/#{uri.host}/#{request.method}#{uri.path}#{uri.query}", &request)
    end
  end

  c.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV['GOOGLE_API_KEY'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_EN>') { ENV['GOOGLE_API_CX_EN'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_CY>') { ENV['GOOGLE_API_CX_CY'] }
end

WebMock.disable_net_connect!(allow: 'codeclimate.com')

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

class FakeFooterRepositoryDefinedInSpecHelper
  def find(_)
    blocks = [
      'raw_web_chat_heading', 'raw_web_chat_additional_one', 'raw_web_chat_additional_two',
      'raw_web_chat_additional_three', 'raw_web_chat_small_print', 'raw_contact_heading',
      'raw_contact_introduction', 'raw_contact_phone_number', 'raw_contact_additional_one',
      'raw_contact_additional_two', 'raw_contact_additional_three', 'raw_contact_small_print'
    ].map do | identifier |
      { 'identifier' => identifier, 'content' => 'I am some content in a footer' }
    end
    { blocks: blocks }
  end
end

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
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

  c.around(:example) do |example|
    if example.metadata[:features]
      Feature.run_with_activated(*example.metadata[:features]) do
        Rails.application.reload_routes!
        Devise.regenerate_helpers!
        Devise.class_variable_set(:@@warden_configured, false)
        Devise.configure_warden!

        example.run
      end

      Rails.application.reload_routes!
      Devise.regenerate_helpers!
      Devise.class_variable_set(:@@warden_configured, false)
      Devise.configure_warden!
    else
      example.run
    end
  end

  c.before(:suite) do
    DatabaseCleaner.clean
    ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:ruby, ENV['SCHEMA'])

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
