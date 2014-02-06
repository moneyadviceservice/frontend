require 'spec_helper'
require_relative './shared_examples/show_resource'

describe 'Action Plan routing' do
  let(:resource_name) { 'action_plans' }

  it_should_behave_like 'a resource'
end
