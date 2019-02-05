RSpec.describe SearchResultCollectionDecorator do
  include Draper::ViewHelpers
  subject(:decorator) { described_class.decorate(result_collection) }

  let(:result) do
    {
      title: '<em>Budget</em> <em>planner</em>',
      description: 'You can use this <em>planner</em>.',
      link: '/en/tools/budget-planner'
    }
  end

  let(:result_collection) do
    SiteSearch::Results.new(
      results: [result],
      total_results: total_results,
      page: page,
      number_of_pages: number_of_pages,
      per_page: per_page,
      query: query
    )
  end
  let(:total_results) { 1 }
  let(:page) { 1 }
  let(:number_of_pages) { 1 }
  let(:per_page) { 10 }
  let(:query) { 'budget planner' }

  it "decorates the collection's items with SearchResultDecorator" do
    expect(subject.first).to be_a SearchResultDecorator
  end

  describe '#page' do
    let(:page) { 1 }

    it 'added one more to the page number' do
      expect(subject.page).to be(1)
    end
  end

  context 'with 5 pages of 10 results' do
    let(:per_page) { 10 }
    let(:total_results) { 50 }

    describe '#first_page?' do
      subject { decorator.first_page? }

      context 'when first page' do
        let(:page) { 1 }

        it { is_expected.to be_truthy }
      end

      context 'when third page' do
        let(:page) { 2 }

        it { is_expected.to be_falsey }
      end

      context 'when fifth page' do
        let(:page) { 4 }

        it { is_expected.to be_falsey }
      end
    end

    describe '#last_page?' do
      let(:number_of_pages) { 5 }
      subject { decorator.last_page? }

      context 'when first page' do
        let(:page) { 1 }

        it { is_expected.to be_falsey }
      end

      context 'when third page' do
        let(:page) { 3 }

        it { is_expected.to be_falsey }
      end

      context 'when fifth page' do
        let(:page) { 5 }

        it { is_expected.to be_truthy }
      end
    end

    describe '#previous_page' do
      subject { decorator.previous_page }

      context 'when first page' do
        let(:page) { 1 }

        it { is_expected.to be_nil }
      end

      context 'when third page' do
        let(:page) { 3 }

        it { is_expected.to eql 2 }
      end

      context 'when fifth page' do
        let(:page) { 5 }

        it { is_expected.to eql 4 }
      end
    end

    describe '#next_page' do
      let(:number_of_pages) { 5 }
      subject { decorator.next_page }

      context 'when first page' do
        let(:page) { 1 }

        it { is_expected.to eql 2 }
      end

      context 'when third page' do
        let(:page) { 3 }

        it { is_expected.to eql 4 }
      end

      context 'when fifth page' do
        let(:page) { 5 }

        it { is_expected.to be_nil }
      end
    end
  end
end
