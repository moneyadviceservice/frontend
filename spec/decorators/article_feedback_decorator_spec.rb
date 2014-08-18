RSpec.describe ArticleFeedbackDecorator do
  include Draper::ViewHelpers

  let(:alternate) { double(title: 'title', hreflang: 'cy', url: 'fake_url') }
  let(:alternates) { [alternate] }
  let(:object) { Core::Article.new('article_id') }
  let(:locale) { 'en' }

  before do
    allow(I18n).to receive(:locale) { locale }
    allow(object).to receive(:alternates) { alternates }
  end

  subject(:decorator) { described_class.decorate(object) }

  describe '#feedback_path' do
    it 'calls the correct path helper' do
      expect(helpers).to receive(:article_feedback_path).with(object.id, locale: locale)
      decorator.feedback_path
    end
  end

  describe '#footer_alternate_options' do
    it 'adds the feedback path to alternates paths' do
      expect(decorator.footer_alternate_options.values.first).to end_with('/feedback/new')
    end

    context 'when alternate match with the current lang' do
      let(:alternate) { double(title: 'title', hreflang: 'en', url: 'fake_url') }

      it 'is excluded from the alternates hash' do
        expect(decorator.footer_alternate_options).to be_empty
      end
    end
  end
end
