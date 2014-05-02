require 'faraday/response/link_header'

describe Faraday::Response::LinkHeader do
  subject(:headers) { connection.get('/').headers }

  let(:connection) do
    Faraday.new do |faraday|
      faraday.response :link_header
      faraday.adapter :test do |stub|
        stub.get('/') { [200, headers, 'ok'] }
      end
    end
  end

  subject(:link_header) { connection.get.headers['Link'] }

  context 'when the response contains a link header' do
    let(:headers) do
      { 'Link' => '<http://example.com/foo>; rel="self", <http://example.com/>; rel = "up"' }
    end

    it 'parses them' do
      expect(link_header.links.first.href).to eq('http://example.com/foo')
      expect(link_header.links.second.href).to eq('http://example.com/')
    end
  end

  context 'when the response contains no link header' do
    let(:headers) { {} }

    it 'does not parse them' do
      expect(link_header).to be_nil
    end
  end
end
