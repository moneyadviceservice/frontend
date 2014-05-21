require 'spec_helper'
require 'core/repositories/search/content_service'

RSpec.describe Core::Repositories::Search::ContentService do
  let(:url) { 'https://example.com/path/to/url' }
  let(:locale) { :en }
  let(:limit) { 25 }
  let(:query) { 'mortgages' }
  let(:event_name) { 'request.content-service.search' }

  before do
    connection = Core::ConnectionFactory.build(url)
    connection.builder.delete(FaradayMiddleware::Instrumentation)

    allow(Core::Registries::Connection).to receive(:[]).with(:content_service) { connection }
  end

  describe '#perform' do
    subject { described_class.new.perform(query) }

    let(:body) { File.read('spec/fixtures/search-results/content-service.json') }
    let(:status) { 200 }

    before do
      stub_request(:get, "https://example.com/path/to/url/search.json?limit=#{limit}&locale=#{locale}&query=#{query}").
        to_return(status: status, body: body, headers: {})
    end

    it 'records an event with Rails instrumentation' do
      expect(ActiveSupport::Notifications).
        to receive(:instrument).
             with(event_name, query: query, locale: locale, limit: limit).
             and_call_original

      subject
    end

    context 'when the request is successful' do
      it { is_expected.to be_a(Array) }

      context 'it reformats the response and' do
        let(:source_body) { JSON.parse(body) }

        context 'for content types of results' do
          let(:source_data) { source_body['searchResults'].detect { |result| result['type'] == 'action-plan' } }
          let(:reformatted_data) { subject.detect { |result| result[:type] == 'action-plan' } }

          it 'maps the id correctly' do
            expect(reformatted_data[:id]).to eql source_data['id']
          end

          it 'maps the title correctly' do
            expect(reformatted_data[:title]).to eql source_data['preview']['title']
          end

          it 'maps the description correctly' do
            expect(reformatted_data[:description]).to eql source_data['preview']['preview']
          end

          it 'maps the type correctly' do
            expect(reformatted_data[:type]).to eql source_data['type']
          end
        end

        context 'for category results' do
          let(:source_data) { source_body['searchResults'].detect { |result| result['type'] == 'category' } }
          let(:reformatted_data) { subject.detect { |result| result[:type] == 'category' } }

          it 'maps the id correctly' do
            expect(reformatted_data[:id]).to eql source_data['id']
          end

          it 'maps the title correctly' do
            expect(reformatted_data[:title]).to eql source_data['preview']['title']
          end

          it 'maps the description correctly' do
            expect(reformatted_data[:description]).to eql source_data['preview']['description']
          end

          it 'maps the type correctly' do
            expect(reformatted_data[:type]).to eql source_data['type']
          end
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
