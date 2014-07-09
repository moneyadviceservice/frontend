require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe NewsReader do
    subject(:news_reader) { described_class.new }

    before do
      allow(Registry::Repository).to receive(:[]).with(:news) do
        double(all: data)
      end
    end

    describe '#call' do
      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        subject(:news) { news_reader.call }

        let(:data) do
          [{
            'id'    => 'news-article-id',
            'title' => 'The title',
            'body'  => 'the body',
            'date'  => '23/09/2011'
          }]
        end

        it { is_expected.to be_an(Array) }

        specify 'elements are news articles' do
          expect(news.first).to be_a(NewsArticle)
        end
      end
    end
  end
end
