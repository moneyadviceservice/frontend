module Core
  RSpec.describe CorporateArticle do
    subject { described_class.new(double, attributes) }

    let(:categories) { [] }
    let(:related_content) do
      {
        'popular_links' => [
          {
            'title' => 'Most popular link.',
            'path' => '/most-popular-link'
          },
          {
            'title' => 'Next popular link.',
            'path' => '/next-popular-link'
          }
        ]
      }
    end
    let(:attributes) do
      {
        title:       double,
        description: double,
        slug:        double,
        body:        double,
        alternates:  [{ title: double, url: double, hreflang: double }],
        categories:  categories,
        related_content: related_content
      }
    end

    describe '#previous_link' do
      context 'exists' do
        let(:related_content) do
          {
            'previous_link' => {
              'title' => 'Previous link.',
              'path' => '/en/articles/previous-article'
            }
          }
        end

        it 'has a previous_link' do
          expect(subject.previous_link.title).to eq('Previous link.')
          expect(subject.previous_link.path).to eq('/en/corporate/previous-article')
        end
      end

      context 'previous_link is empty' do
        let(:related_content) do
          { 'previous_link' => {} }
        end

        it 'previous_link is nil' do
          expect(subject.previous_link).to be_nil
        end
      end

      context 'previous_link is missing' do
        let(:related_content) do
          {}
        end

        it 'previous_link is nil' do
          expect(subject.previous_link).to be_nil
        end
      end

      context 'related_content is missing' do
        let(:related_content) do
          nil
        end

        it 'previous_link is nil' do
          expect(subject.previous_link).to be_nil
        end
      end
    end

    describe '#next_link' do
      context 'exists' do
        let(:related_content) do
          {
            'next_link' => {
              'title' => 'Next link.',
              'path' => '/en/articles/next-article'
            }
          }
        end

        it 'has a next_link' do
          expect(subject.next_link.title).to eq('Next link.')
          expect(subject.next_link.path).to eq('/en/corporate/next-article')
        end
      end

      context 'next_link is empty' do
        let(:related_content) do
          { 'next_link' => {} }
        end

        it 'next_link is nil' do
          expect(subject.next_link).to be_nil
        end
      end

      context 'next_link is missing' do
        let(:related_content) do
          {}
        end

        it 'next_link is nil' do
          expect(subject.next_link).to be_nil
        end
      end

      context 'related_content is missing' do
        let(:related_content) do
          nil
        end

        it 'next_link is nil' do
          expect(subject.next_link).to be_nil
        end
      end
    end

    describe '#related_links' do
      let(:related_content) do
        {
          'related_links' => [
            {
              'title' => 'Most related link.',
              'path' => '/en/articles/most-related-link'
            },
            {
              'title' => 'Next related link.',
              'path' => '/en/articles/next-related-link'
            }
          ]
        }
      end

      context 'provide data' do
        it 'has 2 article links' do
          expect(subject.related_links.length).to eq(2)
        end

        it 'has links correctly built' do
          expect(subject.related_links.first.title).to eq('Most related link.')
          expect(subject.related_links.first.path).to eq('/en/articles/most-related-link')
        end
      end

      context 'no related links' do
        let(:related_content) { {} }

        it 'results in empty list' do
          expect(subject.related_links).to be_empty
        end
      end

      context 'empty related links' do
        let(:related_content) { { 'related_links' => [] } }

        it 'results in empty list' do
          expect(subject.related_links).to be_empty
        end
      end

      context 'no related content' do
        let(:related_content) { nil }

        it 'results in empty list' do
          expect(subject.related_links).to be_empty
        end
      end

      context 'no related related' do
        let(:related_content) { { 'related_links' => nil } }

        it 'results in empty list' do
          expect(subject.related_links).to be_empty
        end
      end
    end
  end
end
