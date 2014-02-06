require_relative '../spec_helper'

describe 'Article routing' do
  let(:resource_name) { 'articles' }

  it_should_behave_like 'a resource'
end
