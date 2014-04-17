require 'spec_helper'
require 'core/repositories/search/google_custom_search'

describe Core::Repositories::Search::GoogleCustomSearch do
  let(:connection) { double }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:google_api) { connection }
  end

  describe '#perform' do
    subject { described_class.new.perform(double) }

    context 'when there is an error' do
      before do
        allow(connection).to receive(:get).and_raise(Core::Connection::ClientError)
      end

      specify do
        expect { subject }.to raise_error(described_class::RequestError)
      end
    end

    context 'when the request is successful' do
      before do
        allow(connection).to receive(:get) { double(body: {}) }
      end

      specify do
        expect(subject).to be_an(Array)
      end
    end
  end
end
