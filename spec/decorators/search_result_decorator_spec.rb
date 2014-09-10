RSpec.describe SearchResultDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(search_result) }

  let(:title) { double }
  let(:description) { double }
  let(:search_result) do
    instance_double(Core::SearchResult, id: 'item-id', title: title, description: description)
  end

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }

  describe '#title' do
    context 'when the site title is appended' do
      let(:title) { 'Item Title - Money Advice Service' }

      it 'removes the the page title' do
        expect(subject.title).to eq('Item Title')
      end
    end

    context 'when the site title is appended then truncated' do
      let(:title) { 'Item Title - Money ...' }

      it 'removes the the page title' do
        expect(subject.title).to eq('Item Title')
      end
    end

    context 'when the site title is not appended' do
      let(:title) { 'Item Title - Something' }

      it 'removes the the page title' do
        expect(subject.title).to eq('Item Title - Something')
      end
    end

    context 'when the site title is not appended but truncated' do
      let(:title) { 'Item Title - Something ...' }

      it 'removes the the page title' do
        expect(subject.title).to eq('Item Title - Something ...')
      end
    end
  end

  describe '#path' do
    let(:link) { 'link' }

    before { allow(search_result).to receive(:link) { link } }

    it 'retuns the link' do
      expect(subject.path).to be(link)
    end
  end

  describe '#description' do
    let(:description) { 'the quick fox jumps over the lazy dog' }
    let(:query) { '' }

    subject { decorator.description }

    before do
      decorator.context = { query: query }
    end

    context 'when the query is empty' do
      it { is_expected.to eq(description) }
    end

    context 'when the query is non-empty' do
      context 'and does not appear in the description' do
        let(:query) { 'budget' }

        it { is_expected.to eq(description) }
      end

      context 'and appears in the description once' do
        let(:query) { 'fox' }

        it { is_expected.to eq('the quick <b>fox</b> jumps over the lazy dog') }
      end

      context 'and appears in the description more than once' do
        let(:query) { 'the' }

        it { is_expected.to eq('<b>the</b> quick fox jumps over <b>the</b> lazy dog') }
      end
    end

    context 'when the description includes capitalisation' do
      let(:description) { 'the quick Fox jumps over the lazy dog' }
      let(:query) { 'fox' }

      it { is_expected.to eq('the quick <b>Fox</b> jumps over the lazy dog') }
    end
  end
end
