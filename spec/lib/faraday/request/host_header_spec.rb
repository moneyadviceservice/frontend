require 'spec_helper'
require 'faraday'
require 'faraday/request/host_header'

describe Faraday::Request::HostHeader do
  subject(:request_headers) { connection.get('/').env[:request_headers] }

  let(:connection) do
    Faraday.new do |faraday|
      faraday.request :host_header
      faraday.adapter :test do |stub|
        stub.get('/') { [200, {}, 'ok'] }
      end
    end
  end

  before do
    stub_const('ENV', { 'FARADAY_HOST' => host })
  end

  context "when ENV['FARADAY_HOST']" do
    let(:host) { 'www.example.com' }

    it "adds a `Host' header" do
      expect(request_headers).to include('Host' => host)
    end
  end

  context "when there is no ENV['FARADAY_HOST']" do
    let(:host) { nil }

    it "doesn't add a `Host' header" do
      expect(request_headers).to_not include('Host')
    end
  end
end
