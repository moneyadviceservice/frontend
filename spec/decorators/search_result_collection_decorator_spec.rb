RSpec.describe SearchResultCollectionDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(result_collection) }

  let(:items) { [double] }
  let(:result_collection) { Core::SearchResultCollection.new(items: items) }

  it "decorates the collection's items with SearchResultDecorator" do
    expect(subject.first).to be_a SearchResultDecorator
  end

  describe '#page' do
    let(:number_of_pages) { 10 }

    before do
      allow(subject).to receive(:number_of_pages) { number_of_pages }
      allow(result_collection).to receive(:page) { page }
    end

    context 'when the requested page number is less than the total number of pages' do
      let(:page) { 5 }

      it 'returns the original requested page number' do
        expect(subject.page).to eq page
      end
    end

    context 'when the requested page number is more than the total number of pages' do
      let(:page) { 15 }

      it 'returns the total number of pages' do
        expect(subject.page).to eq number_of_pages
      end
    end
  end

  describe '#total_results' do
    let(:result_limit) { 50 }

    before do
      allow(subject).to receive(:result_limit) { result_limit }
      allow(result_collection).to receive(:total_results) { total_results }
    end

    context 'when the total number of results is less than the result limit' do
      let(:total_results) { 40 }

      it 'returns the actual number of results' do
        expect(subject.total_results).to eq total_results
      end
    end

    context 'when the total number of results is more than the result limit' do
      let(:total_results) { 100 }

      it 'returns the result limit' do
        expect(subject.total_results).to eq result_limit
      end
    end
  end

  context 'with 5 pages of 10 results' do
    before do
      result_collection.per_page      = 10
      result_collection.total_results = 50
    end

    describe '#first_page?' do
      subject { decorator.first_page? }

      context 'when the current page is 1' do
        before { result_collection.page = 1 }
        it { is_expected.to be_truthy }
      end

      context 'when the current page is 3' do
        before { result_collection.page = 3 }
        it { is_expected.to be_falsey }
      end

      context 'when the current page is 5' do
        before { result_collection.page = 5 }
        it { is_expected.to be_falsey }
      end
    end

    describe '#last_page?' do
      subject { decorator.last_page? }

      context 'when the current page is 1' do
        before { result_collection.page = 1 }
        it { is_expected.to be_falsey }
      end

      context 'when the current page is 3' do
        before { result_collection.page = 3 }
        it { is_expected.to be_falsey }
      end

      context 'when the current page is 5' do
        before { result_collection.page = 5 }
        it { is_expected.to be_truthy }
      end
    end

    describe '#previous_page' do
      subject { decorator.previous_page }

      context 'when the current page is 1' do
        before { result_collection.page = 1 }
        it { is_expected.to be_nil }
      end

      context 'when the current page is 3' do
        before { result_collection.page = 3 }
        it { is_expected.to eql 2 }
      end

      context 'when the current page is 5' do
        before { result_collection.page = 5 }
        it { is_expected.to eql 4 }
      end
    end

    describe '#next_page' do
      subject { decorator.next_page }

      context 'when the current page is 1' do
        before { result_collection.page = 1 }
        it { is_expected.to eql 2 }
      end

      context 'when the current page is 3' do
        before { result_collection.page = 3 }
        it { is_expected.to eql 4 }
      end

      context 'when the current page is 5' do
        before { result_collection.page = 5 }
        it { is_expected.to be_nil }
      end
    end
  end

  describe '#number_of_pages' do
    subject { decorator.number_of_pages }

    context 'with 10 results per page' do
      before { result_collection.per_page = 10 }

      context 'and a total of 20 results' do
        before { result_collection.total_results = 20 }
        it { is_expected.to eql 2 }
      end

      context 'and a total of 15 results' do
        before { result_collection.total_results = 15 }
        it { is_expected.to eql 2 }
      end

      context 'and a total of 10 results' do
        before { result_collection.total_results = 10 }
        it { is_expected.to eql 1 }
      end

      context 'and a total of 5 results' do
        before { result_collection.total_results = 5 }
        it { is_expected.to eql 1 }
      end

      context 'and zero results' do
        before { result_collection.total_results = 0 }
        it { is_expected.to eql 1 }
      end
    end
  end

end
