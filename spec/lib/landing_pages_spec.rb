RSpec.describe LandingPagePaths do
  let(:key) { 'landing_pages.paths.ctrl.actn' }
  let(:english_path) { 'an-path/that-looks-right' }
  let(:welsh_path) { 'a-welsh-path/thats-right' }
  before { allow(I18n).to receive(:t).with(key, locale: :en).and_return(english_path) }
  before { allow(I18n).to receive(:t).with(key, locale: :cy).and_return(welsh_path) }

  describe '#path' do
    subject { described_class.path('ctrl', 'actn', locale) }

    context 'when locale is English' do
      let(:locale) { :en }
      it { is_expected.to eq english_path }
    end

    context 'when locale is Welsh' do
      let(:locale) { :cy }
      it { is_expected.to eq welsh_path }
    end
  end

  describe '#path_with_locale' do
    subject { described_class.path_with_locale('ctrl', 'actn', locale) }

    context 'when locale is English' do
      let(:locale) { :en }
      it { is_expected.to eq "/en/#{english_path}" }
    end

    context 'when locale is Welsh' do
      let(:locale) { :cy }
      it { is_expected.to eq "/cy/#{welsh_path}" }
    end
  end

  describe '#locale_options' do
    subject { described_class.locale_options('ctrl', 'actn', locale) }

    context 'when locale is English' do
      let(:locale) { :en }
      it { is_expected.to eq(cy: "/cy/#{welsh_path}") }
    end

    context 'when locale is Welsh' do
      let(:locale) { :cy }
      it { is_expected.to eq(en: "/en/#{english_path}") }
    end
  end

end
