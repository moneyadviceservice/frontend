RSpec.describe SearchResultDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(search_result) }

  let(:title) { double }
  let(:search_result) do
    instance_double(Core::SearchResult, id: 'item-id', title: title, description: double)
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
end
