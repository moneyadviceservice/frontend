require_relative '../spec_helper'

RSpec.describe 'Article routing', :type => :routing do
  it_should_behave_like 'a resource for', 'articles'
end
