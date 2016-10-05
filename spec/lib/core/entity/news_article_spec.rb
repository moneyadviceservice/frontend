module Core
  RSpec.describe NewsArticle, type: :model do
    subject { described_class.new('news_article_id', attributes) }

    let(:date) { '2014-03-17T09:42:11+00:00' }
    let(:attributes) { { date: date } }

    it { is_expected.to have_attributes(:date) }

    describe '#date' do
      it 'returns a date object' do
        expect(subject.date).to be_a(Date)
      end

      it 'parses the data value' do
        expect(subject.date).to eq(DateTime.parse(date))
      end
    end
  end
end
