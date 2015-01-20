module Core
  RSpec.describe Article do
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
              'path' => '/previous-link'
            }
          }
        end

        it 'has a previous_link' do
          expect(subject.previous_link.title).to eq('Previous link.')
          expect(subject.previous_link.path).to eq('/previous-link')
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
              'path' => '/next-link'
            }
          }
        end

        it 'has a next_link' do
          expect(subject.next_link.title).to eq('Next link.')
          expect(subject.next_link.path).to eq('/next-link')
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

    describe '#latest_blog_post_links' do
      context 'provide data' do
        let(:related_content) do
          {
            'latest_blog_post_links' => [
              {
                'title' => 'Latest post.',
                'path' => '/latest-post',
                'date' => '2015-01-02'
              },
              {
                'title' => 'Oldest post.',
                'path' => '/oldest-post',
                'date' => '2015-01-01'
              }
            ]
          }
        end

        it 'has 2 article' do
          expect(subject.latest_blog_post_links.length).to eq(2)
        end

        it 'has links correctly built' do
          expect(subject.latest_blog_post_links.first.title).to eq('Latest post.')
          expect(subject.latest_blog_post_links.first.path).to eq('/latest-post')
          expect(subject.latest_blog_post_links.first.date).to eq(Date.parse('2015-01-02'))
        end
      end

      context 'no latest_blog_post_links' do
        let(:related_content) { {} }

        it 'results in empty list' do
          expect(subject.latest_blog_post_links).to be_empty
        end
      end

      context 'empty latest_blog_post_links' do
        let(:related_content) { { 'latest_blog_post_links' => [] } }

        it 'results in empty list' do
          expect(subject.latest_blog_post_links).to be_empty
        end
      end

      context 'no related content' do
        let(:related_content) { nil }

        it 'results in empty list' do
          expect(subject.latest_blog_post_links).to be_empty
        end
      end
    end

    describe '#popular_links' do
      context 'provide data' do
        it 'has 2 article links' do
          expect(subject.popular_links.length).to eq(2)
        end

        it 'has links correctly built' do
          expect(subject.popular_links.first.title).to eq('Most popular link.')
          expect(subject.popular_links.first.path).to eq('/most-popular-link')
        end
      end

      context 'no popular links' do
        let(:related_content) { {} }

        it 'results in empty list' do
          expect(subject.popular_links).to be_empty
        end
      end

      context 'empty popular links' do

        let(:related_content) { { 'popular_links' => [] } }

        it 'results in empty list' do
          expect(subject.popular_links).to be_empty
        end
      end

      context 'no related content' do
        let(:related_content) { nil }

        it 'results in empty list' do
          expect(subject.popular_links).to be_empty
        end
      end
    end

    describe '#related_links' do
      let(:related_content) do
        {
          'related_links' => [
            {
              'title' => 'Most related link.',
              'path' => '/most-related-link'
            },
            {
              'title' => 'Next related link.',
              'path' => '/next-related-link'
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
          expect(subject.related_links.first.path).to eq('/most-related-link')
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

    it { is_expected.to have_attributes(:type, :title, :description, :body, :alternates) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }

    describe '#alternates' do
      it 'returns an array of alternates' do
        expect(subject.alternates.first).to be_an_instance_of(Core::Article::Alternate)
      end
    end

    describe '#alternates=' do
      let(:alternate_title) { 'title' }
      let(:url) { 'www.example.com' }
      let(:hreflang) { 'cy' }

      before { subject.alternates = ([{ title: alternate_title, url: url, hreflang: hreflang }]) }

      it 'assigns alternate title' do
        expect(subject.alternates.first.title).to eq(alternate_title)
      end

      it 'assigns alternate url' do
        expect(subject.alternates.first.url).to eq(url)
      end

      it 'assigns alternate hreflang' do
        expect(subject.alternates.first.hreflang).to eq(hreflang)
      end
    end

    describe '#only_child?' do
      context 'belonging to more than one category' do
        let(:categories) { [double, double] }

        it { expect(subject).to_not be_only_child }
      end

      context 'belonging to one category' do
        let(:categories) { [double] }

        it { expect(subject).to be_only_child }
      end

      context 'belonging to no categories' do
        let(:categories) { [] }

        it { expect(subject).to_not be_only_child }
      end
    end

    describe '#callback_requestable?' do
      context 'when it is not requestable' do
        it 'returns false' do
          expect(subject.callback_requestable?).to be_falsey
        end
      end

      context 'when it is requestable' do
        subject { described_class.new('managing-your-money-if-your-job-is-at-risk', attributes) }

        it 'returns true' do
          expect(subject.callback_requestable?).to be_truthy
        end
      end
    end
  end
end
