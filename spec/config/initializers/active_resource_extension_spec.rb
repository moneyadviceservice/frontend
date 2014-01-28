require 'spec_helper'

describe ActiveResource::Base do
  before(:all) do
    Dummy = Class.new(ActiveResource::Base) { self.site = 'http://example.com' }
  end

  before(:each) do
    FakeWeb.register_uri(:get, 'http://example.com/dummies/id.json',
                         status: 200, body: '{}')

    Thread.current['request-id'] = request_id
  end

  after(:each) do
    FakeWeb.last_request = nil
  end

  describe '.find' do
    before { Dummy.find('id') }

    context 'when there is no request-id in the current thread' do
      let(:request_id) { nil }

      it "does not set a `X-Request-Id' header the request" do
        expect(FakeWeb.last_request['X-Request-Id']).to be_nil
      end
    end

    context 'when there is a request-id in the current thread' do
      let(:request_id) { 'abc123' }

      it "adds a `X-Request-Id' header to the request" do
        expect(FakeWeb.last_request['X-Request-Id']).to eq(request_id)
      end
    end
  end
end
