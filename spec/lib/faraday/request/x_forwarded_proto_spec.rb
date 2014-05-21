require 'faraday/request/x_forwarded_proto'

RSpec.describe Faraday::Request::XForwardedProto do
  subject(:request_headers) { connection.get('/').env[:request_headers] }

  let(:connection) do
    Faraday.new do |faraday|
      faraday.request :x_forwarded_proto
      faraday.adapter :test do |stub|
        stub.get('/') { [200, {}, 'ok'] }
      end
    end
  end

  before do
    stub_const('ENV', { 'FARADAY_X_FORWARDED_PROTO' => protocol })
  end

  context "when ENV['FARADAY_X_FORWARDED_PROTO']" do
    let(:protocol) { 'https' }

    it "adds a `X-Forwarded-Proto' header" do
      expect(request_headers).to include('X-Forwarded-Proto' => protocol)
    end
  end

  context "when there is no ENV['FARADAY_X_FORWARDED_PROTO']" do
    let(:protocol) { nil }

    it "doesn't add a `X-Forwarded-Proto' header" do
      expect(request_headers).to_not include('X-Forwarded-Proto')
    end
  end
end
