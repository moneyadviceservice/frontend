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

    describe '#popular_links' do
      context 'provide data' do
        it 'has 2 article links' do
          expect(subject.popular_links.length).to eq(2)
          expect(subject.popular_links.first).to be_an_instance_of(ArticleLink)
          expect(subject.popular_links.last).to be_an_instance_of(ArticleLink)
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
