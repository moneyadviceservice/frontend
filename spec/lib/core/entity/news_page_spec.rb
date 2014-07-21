module Core
  RSpec.describe NewsPage do
    subject(:page) { described_class.new(options) }

    let(:options) { {} }

    it { is_expected.to respond_to :items }
    it { is_expected.to respond_to :page_number }

    it 'is a collection' do
      expect(subject.to_a).to be_kind_of(Array)
    end

    it 'is empty by default' do
      expect(subject).to be_empty
    end

    describe '#page_number' do
      it 'is nil by default' do
        expect(subject.page_number).to be_nil
      end
    end

    describe '#next_page?' do
      let(:options) { { items: items } }

      context 'when current page size is equals to default page size' do
        let(:items) { double(size: 10) }

        specify { expect(page.next_page?).to be_truthy }
      end

      context 'when current page size is not equals to default page size' do
        let(:items) { double(size: 9) }

        specify { expect(page.next_page?).to be_falsy }
      end
    end
  end
end
