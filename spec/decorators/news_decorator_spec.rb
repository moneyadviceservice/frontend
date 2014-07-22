RSpec.describe NewsDecorator do
  subject(:decorator) { described_class.decorate(news_collection) }

  let(:items) { [double, double] }
  let(:page_number) { 1 }
  let(:news_collection) { Core::NewsPage.new(items: items, page_number: page_number) }

  it 'decorates the collection items with NewsArticleDecorator' do
    expect(decorator.first).to be_a(NewsArticleDecorator)
  end

  describe '#canonical_url' do
    it 'calls to the correct path helper' do
      expect(helpers).to receive(:news_url)

      subject.canonical_url
    end
  end

  describe '#alternate_options' do
    it 'returns an alternates hash' do
      allow(helpers).to receive(:news_url).and_return('/sample_url')

      expect(subject.alternate_options).to eq({ :'en-GB' => '/sample_url', :'cy-GB' => '/sample_url' })
    end
  end
end
