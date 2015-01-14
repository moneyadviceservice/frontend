RSpec.describe MountController, type: :controller do
  before do
    allow(subject).to receive(:alternate_engine_id) { 'alternative_engine' }
  end

  describe '#breadcrumbs' do
    it 'returns breadcrumb of just home' do
      trail = subject.send(:breadcrumbs)
      expect(trail.size).to eql(1)
      expect(trail.first.title).to eql('Home')
    end
  end

  describe '#alternate_url' do
    it 'returns an alternate_url if one is available' do
      expect(subject).to receive(:url_for).with('script_name' => '/cy/alternative_engine')
      subject.send(:alternate_url)
    end
  end

  describe '#alternate_options' do
    it 'returns current option' do
      request = double(url: 'some_url')
      allow(subject).to receive(:request) { request }

      alternative = 'http://example.com/en/engine'
      allow(subject).to receive(:url_for) { alternative }
      allow(subject).to receive(:params) { { locale: 'en' } }

      outcome = subject.send(:alternate_options)['en-GB']
      expect(outcome).to eql('some_url')
    end

    it 'returns alternative option' do
      expected = 'http://example.com/en/engine'
      allow(subject).to receive(:url_for) { expected }

      outcome = subject.send(:alternate_options)['cy-GB']
      expect(outcome).to eql(expected)
    end
  end
end
