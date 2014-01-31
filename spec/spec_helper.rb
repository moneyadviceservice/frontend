ENV['RAILS_ENV'] = 'test'

require_relative '../config/environment'
require 'mas/development_dependencies/rspec/spec_helper'
require 'webmock/rspec'

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behavior, 'exhibits behaviour of an'
end
