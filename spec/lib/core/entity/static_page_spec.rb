module Core
  RSpec.describe StaticPage, type: :model do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title:        double,
        description:  double,
        body:         double,
        translations: [{ label: double, link: double('link').as_null_object, language: double }.stringify_keys]
      }
    end

    it { is_expected.to have_attributes(:type, :title, :description, :body, :label, :meta_description, :translations) }

    it { is_expected.to validate_presence_of(:title) }

    describe '#alternates' do
      it 'returns an array of alternates' do
        expect(subject.alternates.first).to be_an_instance_of(Core::StaticPage::Alternate)
      end
    end

    describe '#translations=' do
      let(:alternate_title) { 'title' }
      let(:url) { 'www.example.com/corporate/foo' }
      let(:hreflang) { 'cy' }

      before { subject.translations = ([{ label: alternate_title, link: url, language: hreflang }.stringify_keys]) }

      it 'assigns alternate title' do
        expect(subject.alternates.first.title).to eq(alternate_title)
      end

      it 'assigns alternate url' do
        expect(subject.alternates.first.url).to eq('www.example.com/static/foo')
      end

      it 'assigns alternate hreflang' do
        expect(subject.alternates.first.hreflang).to eq(hreflang)
      end
    end
  end
end
