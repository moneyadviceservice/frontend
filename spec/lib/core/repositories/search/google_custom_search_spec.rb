require 'spec_helper'
require 'core/repositories/search/google_custom_search'

describe Core::Repositories::Search::GoogleCustomSearch do
  let(:cx_en) { double }
  let(:cx_cy) { double }
  subject(:google_custom_search) { described_class.new(double, cx_en, cx_cy) }

  let(:connection) { double }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
  end

  describe '#perform' do
    subject(:perform_custom_search) { google_custom_search.perform(double) }

    context 'when there is an error' do
      before do
        allow(connection).to receive(:get).and_raise(Core::Connection::ClientError)
      end

      specify do
        expect { perform_custom_search }.to raise_error(described_class::RequestError)
      end
    end

    context 'when the request is successful' do
      before do
        allow(connection).to receive(:get) { double(body: {}) }
      end

      specify do
        expect(perform_custom_search).to be_an(Array)
      end
    end

    context 'when locale is :en' do
      before { I18n.locale = :en }

      it 'sets the connection with the google :en engine' do
        expect(connection).to receive(:get).with(anything, { key: anything, cx: cx_en, q: anything }) { double(body: {}) }

        perform_custom_search
      end
    end

    context 'when locale is :cy' do
      before { I18n.locale = :cy }

      it 'sets the connection with the google :cy engine' do
        expect(connection).to receive(:get).with(anything, { key: anything, cx: cx_cy, q: anything }) { double(body: {}) }

        perform_custom_search
      end
    end
  end
end
