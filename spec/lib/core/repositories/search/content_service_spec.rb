require 'spec_helper'
require 'core/repositories/search/content_service'

describe Core::Repositories::Search::ContentService do
  let(:url) { 'https://example.com/path/to/url' }
  let(:locale) { 'en' }
  let(:limit) { 25 }
  let(:query) { 'mortgages' }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:content_service) do
      Core::ConnectionFactory.build(url)
    end
  end

  describe '#perform' do
    subject { described_class.new.perform(query) }

    before do
      stub_request(:get, "https://example.com/path/to/url/search.json?limit=#{limit}&locale=#{locale}&query=#{query}").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the request is successful' do
      let(:body) { File.read('spec/fixtures/search-results/content-service.json') }
      let(:status) { 200 }

      it { should be_a(Array) }

      context 'it reformats the response and' do
        let(:source_data) { JSON.parse(body) }
        let(:first_element) { source_data['searchResults'].first }

        it 'maps the id correctly' do
          subject.first[:id].should eql first_element['id']
        end

        it 'maps the title correctly' do
          subject.first[:title].should eql first_element['preview']['title']
        end

        it 'maps the description correctly' do
          subject.first[:description].should eql first_element['preview']['preview']
        end

        it 'maps the type correctly' do
          subject.first[:type].should eql first_element['type']
        end
      end
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { subject }.to raise_error(described_class::RequestError) }
    end
  end
end
