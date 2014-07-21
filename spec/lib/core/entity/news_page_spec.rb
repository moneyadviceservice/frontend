module Core
  RSpec.describe NewsPage do
    subject(:news_collection) { described_class.new() }

    it { is_expected.to respond_to :items }
    it { is_expected.to respond_to :page }

    it 'is a collection' do
      expect(subject.to_a).to be_kind_of(Array)
    end

    it 'is empty by default' do
      expect(subject).to be_empty
    end

    describe '#page' do
      it 'is nil by default' do
        expect(subject.page).to be_nil
      end
    end
  end
end
