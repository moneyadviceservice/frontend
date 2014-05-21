require 'spec_helper'
require 'core/repositories/search/google_custom_search_engine'

module Core::Repositories::Search
  RSpec.describe GoogleCustomSearchEngine do
    let(:key) { double }
    let(:cx_en) { double }
    let(:cx_cy) { double }
    subject(:custom_search_engine) { described_class.new(key, cx_en, cx_cy) }

    let(:connection) { double }
    let(:mapper) { double }
    let(:mapped_response) { double }

    before do
      allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
      allow_any_instance_of(GoogleCustomSearchEngine::ResponseMapper).
        to receive(:mapped_response).and_return(mapped_response)
    end

    describe '#perform' do
      let(:event_name) { 'request.google_api.search' }
      let(:query) { double }
      let(:page) { 1 }
      let(:per_page) { 10 }

      subject(:perform_search) { custom_search_engine.perform(query, page, per_page) }

      it 'records an event with Rails instrumentation' do
        allow(connection).to receive(:get) { double(body: {}) }

        expect(ActiveSupport::Notifications).
          to receive(:instrument).
               with(event_name, hash_including(query: query, locale: I18n.locale, page: page, per_page: per_page)).
               and_call_original

        perform_search
      end

      context 'when there is an error' do
        before do
          allow(connection).to receive(:get).and_raise(Core::Connection::ClientError)
        end

        it 'raises a request error' do
          expect { perform_search }.to raise_error(described_class::RequestError)
        end
      end

      context 'when the request is successful' do
        before do
          allow(connection).to receive(:get) { double(body: {}) }
        end

        it 'returns the mapped response' do
          expect(perform_search).to eq mapped_response
        end
      end

      context 'when locale is :en' do
        let(:expected_params) { { key: anything, cx: cx_en, q: anything, num: anything, start: anything } }
        before { I18n.locale = :en }

        it 'sets the connection with the :en engine' do
          expect(connection).to receive(:get).with(anything, expected_params) { double(body: {}) }

          perform_search
        end
      end

      context 'when locale is :cy' do
        let(:expected_params) { { key: anything, cx: cx_cy, q: anything, num: anything, start: anything } }
        before { I18n.locale = :cy }

        it 'sets the connection with the :cy engine' do
          expect(connection).to receive(:get).with(anything, expected_params) { double(body: {}) }

          perform_search
        end
      end
    end
  end
end
