require 'spec_helper'
require_relative './shared_examples/show_resource'

describe 'Action Plan routing' do
  it_should_behave_like 'a resource for', 'action_plans'
end
