require 'core/entities/article'

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

    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :type= }

    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :title= }

    it { is_expected.to respond_to :description }
    it { is_expected.to respond_to :description= }

    it { is_expected.to respond_to :body }
    it { is_expected.to respond_to :body= }

    it { is_expected.to respond_to :alternates }
    it { is_expected.to respond_to :alternates= }

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

    describe '#one_parent?' do
      context 'when article has more than one category' do
        let(:categories) { [double, double] }

        it { should_not be_one_parent }
      end

      context 'when article has one category' do
        let(:categories) { [double] }

        it { should be_one_parent }
      end

      context 'when article has no categories' do
        it { expect(subject).to_not be_one_parent }
      end
    end
  end
end
