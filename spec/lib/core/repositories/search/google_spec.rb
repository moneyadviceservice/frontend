require 'spec_helper'
require 'core/repositories/search/google'

describe Core::Repositories::Search::Google  do
  describe '#perform' do
    let(:url) { 'https://example.com/path/to/url' }
    let(:query) { 'tools' }
    let(:search_options) { "key=#{ENV['GOOGLE_API_KEY']}&cx=#{ENV['GOOGLE_API_CX']}&q=#{query}" }
    let(:status) { 200 }
    let(:body) { { 'items' => ['title' => 'title'] } }

    before do
      connection = Core::ConnectionFactory.build(url)
      allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
      stub_request(:get, "https://example.com/path/to/url/customsearch/v1?#{search_options}").
        to_return(status: status, body: body, headers: {})
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { described_class.new.perform(query) }.to raise_error(described_class::RequestError) }
    end

    context 'when the request is successful' do
      let(:request_mapper) { double(map: ['item']) }

      subject { described_class.new }

      before { subject.request_mapper = request_mapper}

      it 'returns an array' do
        expect(subject.perform(query)).to be_an(Array)
      end
    end
  end
end
