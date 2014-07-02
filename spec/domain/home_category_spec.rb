RSpec.describe HomeCategory do
  let(:locale) { :en }

  subject { described_class.new }

  before do
    allow(I18n).to receive(:locale).and_return(locale)
  end

  specify { expect(subject).to be_home }
  specify { expect(subject).to_not be_news }
  specify { expect(subject.title).to eq(I18n.t('layouts.home')) }
  specify { expect(subject.path).to eq(root_path(locale: locale)) }
end
