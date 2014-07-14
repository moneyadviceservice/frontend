RSpec.describe NewsDecorator do
  subject(:decorator) { described_class.decorate(news_collection) }

  let(:items) { [double, double] }
  let(:page) { 1 }
  let(:news_collection) { Core::NewsCollection.new(items: items, page: page) }

  it 'decorates the collection items with NewsArticleDecorator' do
    expect(decorator.first).to be_a(NewsArticleDecorator)
  end

  describe '#prev_page' do
    let(:page) { 2 }

    specify { expect(decorator.prev_page).to eq(1) }
  end

  describe '#next_page' do
    let(:page) { 1 }

    specify { expect(decorator.next_page).to eq(2) }
  end

  describe '#next_page?' do
    context 'when the number of items match the page size' do
      let(:items) { Array.new(NewsDecorator::PAGE_SIZE) }

      specify { expect(subject.next_page?).to be_truthy }
    end

    context 'when number of items does not match with page size' do
      let(:items) { [double] }

      specify { expect(subject.next_page?).to be_falsy }
    end
  end

  describe '#prev_page?' do
    context 'when page is bigger than 1' do
      let(:page) { 2 }

      specify { expect(subject.prev_page?).to be_truthy }
    end

    context 'when page is smaller than 2' do
      let(:page) { 1 }

      specify { expect(subject.prev_page?).to be_falsy }
    end
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

      expect(subject.alternate_options).to eq({ en: '/sample_url', cy: '/sample_url' })
    end
  end
end
