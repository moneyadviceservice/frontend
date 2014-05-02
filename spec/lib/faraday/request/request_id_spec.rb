require 'faraday/request/request_id'

describe Faraday::Request::RequestId do
  subject(:request_headers) { connection.get('/').env[:request_headers] }

  let(:connection) do
    Faraday.new do |faraday|
      faraday.request :request_id
      faraday.adapter :test do |stub|
        stub.get('/') { [200, {}, 'ok'] }
      end
    end
  end

  before do
    allow(CurrentRequestId).to receive(:get) { request_id }
  end

  context 'when there is a current request id' do
    let(:request_id) { 'abc-123' }

    it "adds a `X-Request-Id' header" do
      expect(request_headers).to include('X-Request-Id' => request_id)
    end
  end

  context 'when there is no current request id' do
    let(:request_id) { nil }

    it "doesn't add a `X-Request-Id' header" do
      expect(request_headers).to_not include('X-Request-Id')
    end
  end
end
