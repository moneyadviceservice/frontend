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
  it { is_expected.to respond_to(:images) }

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

  describe '#related_links_title' do
    subject { decorator.related_links_title }

    context 'when category has content' do
      let(:category) { double(contents: [double]) }
      let(:heading_html) { double }

      before { allow(helpers).to receive(:heading_tag) { heading_html } }

      it { is_expected.to eq(heading_html) }
    end

    context 'when category has no content' do
      let(:category) { double(contents: []) }

      it { is_expected.to be_nil }
    end
  end

  describe '#large_image' do
    context 'when has large image' do
      let(:category) do
        instance_double(Core::Category, images: { 'large' => '/large/image' })
      end

      it 'returns large image' do
        expect(subject.large_image).to eq('/large/image')
      end
    end

    context 'when does not have large image' do
      let(:category) do
        instance_double(Core::Category, images: { 'large' => nil })
      end

      it 'returns nil' do
        expect(subject.large_image).to be_nil
      end
    end

    context 'when does not have images' do
      let(:category) do
        instance_double(Core::Category, images: nil)
      end

      it 'returns nil' do
        expect(subject.large_image).to be_nil
      end
    end
  end

  describe '#small_image' do
    context 'when has small image' do
      let(:category) do
        instance_double(Core::Category, images: { 'small' => '/small/image' })
      end

      it 'returns large image' do
        expect(subject.small_image).to eq('/small/image')
      end
    end

    context 'when does not have small image' do
      let(:category) do
        instance_double(Core::Category, images: { 'small' => nil })
      end

      it 'returns nil' do
        expect(subject.small_image).to be_nil
      end
    end

    context 'when does not have images' do
      let(:category) do
        instance_double(Core::Category, images: nil)
      end

      it 'returns nil' do
        expect(subject.small_image).to be_nil
      end
    end
  end

  describe '#images?' do
    context 'when there is only a small image' do
      let(:category) do
        instance_double(Core::Category, images: { 'small' => '/small/image' })
      end

      it 'returns false' do
        expect(subject.images?).to be_falsey
      end
    end

    context 'when there are small and large images' do
      let(:category) do
        instance_double(Core::Category, images: { 'small' => '/small/image',
                                                  'large' => '/large/image' })
      end

      it 'returns true' do
        expect(subject.images?).to be_truthy
      end
    end
  end

  describe '#rendering_args' do
    context 'when object contains legacy contents' do
      let(:category) { Core::Category.new(nil, legacy_contents: [:foo]) }

      specify { expect(subject.rendering_args.first).to eq 'relay_page' }
      specify { expect(subject.rendering_args.last).to include(:contents) }
    end

    context 'when object is a parent' do
      let(:category) { Core::Category.new(nil, contents: [double(:child? => true)], legacy_contents: []) }

      specify { expect(subject.rendering_args.first).to eq 'child_categories' }
      specify { expect(subject.rendering_args.last).to include(:contents) }
    end

    context 'when object is a child' do
      let(:category) { Core::Category.new(nil, contents: [], legacy_contents: []) }

      specify { expect(subject.rendering_args.first).to eq 'content_items_all' }
      specify { expect(subject.rendering_args.last).to include(:contents) }
    end
  end
end
