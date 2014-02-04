require 'spec_helper'

describe 'Errors routing' do
  %w(404 500).each do |error|
    context "when exception is #{error}" do
      it 'routes to the exceptions controller' do
        expect(get(error)).to route_to(controller: 'errors', action: 'show', status: error)
      end
    end
  end
end
