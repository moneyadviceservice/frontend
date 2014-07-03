RSpec.describe Core::Repository::Categories::PublicWebsite do
  let(:url) { 'https://example.com/path/to/url' }
  let(:id) { 'life-events' }

  before do
    allow(Core::Registry::Connection).to receive(:[]).with(:public_website) do
      Core::ConnectionFactory.build(url)
    end
  end

  describe '#all' do
    subject { described_class.new.all }

    before do
      stub_request(:get, "https://example.com/en/categories.json").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the request is successful' do
      let(:body) { "[#{File.read('spec/fixtures/%s.json' % id)}]" }
      let(:status) { 200 }

      it { is_expected.to be_a(Array) }
      specify { expect(subject.first['id']).to eq(id) }
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { subject }.to raise_error(described_class::RequestError) }
    end
  end

  describe '#find' do
    subject { described_class.new.find(id) }

    before do
      stub_request(:get, "https://example.com/en/categories/#{id}.json").
        to_return(status: status, body: body, headers: {})
    end

    context 'when the category exists' do
      let(:body) { File.read('spec/fixtures/%s.json' % id) }
      let(:status) { 200 }

      it { is_expected.to be_a(Hash) }
      specify { expect(subject['id']).to eq(id) }
    end

    context 'when the category is non-existent' do
      let(:body) { nil }
      let(:status) { 404 }

      it { is_expected.to be_nil }
    end

    context 'when there is an error' do
      let(:body) { nil }
      let(:status) { 500 }

      specify { expect { subject }.to raise_error(described_class::RequestError) }
    end
  end
end
