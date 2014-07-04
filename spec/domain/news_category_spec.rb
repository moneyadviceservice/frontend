RSpec.describe NewsCategory do
  let(:locale) { :en }

  subject { described_class.new }

  before do
    allow(I18n).to receive(:locale).and_return(locale)
  end

  specify { expect(subject).to_not be_home }
  specify { expect(subject).to be_news }
  specify { expect(subject.title).to eq(I18n.t('footer.news')) }
  specify { expect(subject.path).to eq(I18n.t('footer.news_link')) }
end
