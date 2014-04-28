require 'spec_helper'
require 'core/repositories/search/google_custom_search_engine'

describe Core::Repositories::Search::GoogleCustomSearchEngine do
  let(:cx_en) { double }
  let(:cx_cy) { double }
  subject(:custom_search_engine) { described_class.new(double, cx_en, cx_cy) }

  let(:connection) { double }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
  end

  describe '#perform' do
    let(:event_name) { 'request.google_api.search' }
    let(:query) { double }

    subject(:perform_search) { custom_search_engine.perform(query) }

    it 'records an event with Rails instrumentation' do
      allow(connection).to receive(:get) { double(body: {}) }

      expect(ActiveSupport::Notifications).
        to receive(:instrument).
             with(event_name, hash_including(query: query, locale: I18n.locale)).
             and_call_original

      perform_search
    end

    context 'when there is an error' do
      before do
        allow(connection).to receive(:get).and_raise(Core::Connection::ClientError)
      end

      specify do
        expect { perform_search }.to raise_error(described_class::RequestError)
      end
    end

    context 'when the request is successful' do
      before do
        allow(connection).to receive(:get) { double(body: {}) }
      end

      specify do
        expect(perform_search).to be_an(Array)
      end
    end

    context 'when locale is :en' do
      before { I18n.locale = :en }

      it 'sets the connection with the :en engine' do
        expect(connection).to receive(:get).with(anything, { key: anything, cx: cx_en, q: anything }) { double(body: {}) }

        perform_search
      end
    end

    context 'when locale is :cy' do
      before { I18n.locale = :cy }

      it 'sets the connection with the :cy engine' do
        expect(connection).to receive(:get).with(anything, { key: anything, cx: cx_cy, q: anything }) { double(body: {}) }

        perform_search
      end
    end
  end
end
