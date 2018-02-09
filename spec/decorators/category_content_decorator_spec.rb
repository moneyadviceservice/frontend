RSpec.describe CategoryContentDecorator do
  include Draper::ViewHelpers

  let(:item) { Object.new }
  let(:locale) { 'en' }

  before { allow(I18n).to receive(:locale) { locale } }

  subject(:decorator) { described_class.decorate(item) }

  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:label) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:contents) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:icon_class) }

  describe '#initial_contents' do
    context 'when 3 items' do
      before :each do
        allow(subject).to receive(:contents) { [1, 2, 3] }
      end

      it 'returns 3 items' do
        expect(subject.initial_contents.size).to eql(3)
      end
    end

    context 'when 10 items' do
      before :each do
        allow(subject).to receive(:contents) { (1..10).to_a }
      end

      it 'returns 3 items' do
        expect(subject.initial_contents.size).to eql(3)
      end
    end
  end

  describe '#extended_contents' do
    context 'when 3 items' do
      before :each do
        allow(subject).to receive(:contents) { [1, 2, 3] }
      end

      it 'returns 0 items' do
        expect(subject.extended_contents).to be_empty
      end
    end

    context 'when 10 items' do
      before :each do
        allow(subject).to receive(:contents) { (1..10).to_a }
      end

      it 'returns 7 items' do
        expect(subject.extended_contents.size).to eql(7)
      end
    end
  end

  describe '#label' do
    let(:item) { double(type: 'foo_bar-baz') }

    it 'returns capitalised string of the object type with - suffix' do
      expect(subject.label).to eq('Foo Bar Baz - ')
    end
  end

  describe '#path' do
    context 'with a Category' do
      let(:item) { Mas::Cms::Category.new('test-category') }

      it 'calls the correct path helper' do
        expect(helpers).to receive(:category_path).with(item.id, locale: locale)
        subject.path
      end
    end

    context 'with an Article' do
      let(:item) { Mas::Cms::Article.new('test-article') }

      it 'calls the correct path helper' do
        expect(helpers).to receive(:article_path).with(item.id, locale: locale)
        subject.path
      end
    end

    context 'with an Other' do
      let(:item) { Mas::Cms::Other.new('item-id') }

      it 'returns the correct path' do
        %w[campaign news tool video].each do |type|
          allow(item).to receive_messages(type: type)
          expect(subject.path).to eq "/#{locale}/#{type.pluralize}/#{item.id}"
        end
      end
    end
  end

  describe '#icon_class' do
    let(:item) { double(type: 'foo_bar-baz') }

    it 'returns dasherised string of object type with icon-- prefix' do
      expect(subject.icon_class).to eq('icon--foo-bar-baz')
    end
  end

  describe '#category??' do
    context 'category' do
      let(:item) { double(type: 'category') }
      specify { expect(decorator).to be_category }
    end

    context 'guide' do
      let(:item) { double(type: 'guide') }
      specify { expect(decorator).to_not be_category }
    end
  end
end
