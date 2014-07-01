require_relative './shared_examples/show_resource'

RSpec.describe 'News routing', :type => :routing do
  it_should_behave_like 'a resource for', 'news'
end

