require 'spec_helper'
require 'core/repositories/search/google'

describe Core::Repositories::Search::Google  do
  describe '#perform' do
    let(:url) { 'https://example.com/path/to/url' }
    let(:query) { 'tools' }
    let(:search_options) { "key=#{ENV['GOOGLE_API_KEY']}&cx=#{ENV['GOOGLE_API_CX']}&q=#{query}" }

    before do
      connection = Core::ConnectionFactory.build(url)
      allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
      stub_request(:get, "https://example.com/path/to/url/customsearch/v1?#{search_options}").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the request is successful' do
      let(:status) { 200 }
      let(:body) { File.read('spec/fixtures/search-results/google-customer-search.json') }
      subject { described_class.new.perform(query) }

      it { should be_a(Array) }
    end
  end
end
