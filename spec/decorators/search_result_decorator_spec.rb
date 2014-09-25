RSpec.describe SearchResultDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(search_result) }

  let(:title) { double }
  let(:snippet) { double }
  let(:search_result) do
    instance_double(Core::SearchResult, id: 'item-id', title: title, snippet: snippet)
  end

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:title) }

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

  describe '#snippet' do
    subject { decorator.snippet }

    let(:snippet) do
      '<p>If you created your <b>budget</b> plan <br></p>'
    end

    before { allow(search_result).to receive(:snippet) { snippet } }

    it { is_expected.to eq('<p>If you created your <b>budget</b> plan </p>') }
  end
end
