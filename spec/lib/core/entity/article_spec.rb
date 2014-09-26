module Core
  RSpec.describe Article do
    subject { described_class.new(double, attributes) }

    let(:categories) { [] }
    let(:attributes) do
      { title:       double,
        description: double,
        body:        double,
        alternates:  [{ title: double, url: double, hreflang: double }],
        categories:  categories
      }
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

      before { subject.alternates=([{ title: alternate_title, url: url, hreflang: hreflang }]) }

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
        subject { described_class.new("managing-your-money-if-your-job-is-at-risk", attributes) }

        it 'returns true' do
          expect(subject.callback_requestable?).to be_truthy
        end
      end
    end
  end
end
