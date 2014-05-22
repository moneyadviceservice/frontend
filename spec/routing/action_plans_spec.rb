require_relative './shared_examples/show_resource'

RSpec.describe 'Action Plan routing', :type => :routing do
  it_should_behave_like 'a resource for', 'action_plans'
end
