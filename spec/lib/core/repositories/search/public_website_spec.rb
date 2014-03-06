require 'spec_helper'
require 'core/repositories/search/public_website'

describe Core::Repositories::Search::PublicWebsite do
  let(:url) { 'https://example.com/path/to/url' }
  let(:query) { 'mortgages' }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:public_website) do
      Core::ConnectionFactory.build(url)
    end
  end

  describe '#perform' do
    subject { described_class.new.perform(query) }

    before do
      stub_request(:get, "https://example.com/en/search?query=#{query}").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the request is successful' do
      let(:body) { File.read('spec/fixtures/search-results/public-website.json') }
      let(:status) { 200 }

      it { should be_a(Array) }
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { subject }.to raise_error(described_class::RequestError) }
    end
  end
end
