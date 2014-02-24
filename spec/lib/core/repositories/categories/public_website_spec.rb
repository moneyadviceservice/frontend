require 'spec_helper'
require 'core/repositories/categories/public_website'

describe Core::Repositories::Categories::PublicWebsite do
  let(:url) { 'https://example.com/path/to/url' }

  before do
    allow(Core::Registries::Connection).to receive(:[]).with(:public_website) do
      Core::ConnectionFactory.build(url)
    end
  end

  describe '#find' do
    let(:id) { 'life-events' }

    subject { described_class.new.find(id) }

    before do
      stub_request(:get, "https://example.com/en/categories/#{id}.json").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the category exists' do
      let(:body) { File.read('spec/fixtures/%s.json' % id) }
      let(:status) { 200 }

      it { should be_a(Hash) }
      specify { expect(subject['id']).to eq(id) }
    end

    context 'when the category is non-existent' do
      let(:body) { nil }
      let(:status) { 404 }

      it { should be_nil }
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { subject }.to raise_error(described_class::RequestError) }
    end
  end
end
