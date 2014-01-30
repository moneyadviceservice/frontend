require 'spec_helper'
require 'current_request_id'

describe ActiveResource::Base do
  before(:all) do
    Dummy = Class.new(ActiveResource::Base) { self.site = 'http://example.com' }
  end

  after(:all) { CurrentRequestId.clear! }

  before(:each) do
    stub_request(:get, "http://example.com/dummies/id.json").to_return( body: '{}')
    CurrentRequestId.set(request_id)
  end

  describe '.find' do
    before { Dummy.find('id') }

    context 'when there is no request-id in the current thread' do
      let(:request_id) { nil }

      it "does not set a `X-Request-Id' header the request" do
        expect(a_request(:get, "http://example.com/dummies/id.json").
          with(headers: { 'X-Request-Id' => request_id })).to_not have_been_made
      end
    end

    context 'when there is a request-id in the current thread' do
      let(:request_id) { 'abc123' }

      it "adds a `X-Request-Id' header to the request" do
        expect(a_request(:get, "http://example.com/dummies/id.json").
          with(headers: { 'X-Request-Id' => request_id })).to have_been_made
      end
    end
  end
end
