ENV['RAILS_ENV'] = 'test'

require_relative '../config/environment'
require 'mas/development_dependencies/rspec/spec_helper'
require 'webmock/rspec'

Capybara.server do |app, port|
  if Konacha.mode == :runner
    require 'rack/handler/thin'
    Rack::Handler::Thin.run(app, Port: port)
  else
    Capybara.run_default_server(app, port)
  end
end if defined?(Capybara)

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'
end
