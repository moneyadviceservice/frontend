require 'core/entities/category'

RSpec.describe CategoryDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(category) }

  let(:category) do
    instance_double(Core::Category, id: double, title: double, description: double)
  end

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:contents) }
  it { is_expected.to respond_to(:canonical_url) }
  it { is_expected.to respond_to(:alternate_options) }

  describe '#alternate_options' do
    let(:locale) { double }
    let(:url) { double }

    before do
      allow(I18n).to receive_messages(available_locales: [locale])
      allow(helpers).to receive_messages(category_url: url)
    end

    it 'returns a hash of locale => url pairs' do
      expect(subject.alternate_options).to include("#{locale}-GB" => url)
    end
  end

  describe '#path' do
    before { allow(helpers).to receive_messages(category_path: '/categories/test') }

    it 'returns the path to the category' do
      expect(subject.path).to eq('/categories/test')
    end
  end

  describe '#canonical_url' do
    before { allow(helpers).to receive_messages(category_url: '/categories/bob') }

    it 'returns the path to the category' do
      expect(subject.canonical_url).to eq('/categories/bob')
    end
  end
end
