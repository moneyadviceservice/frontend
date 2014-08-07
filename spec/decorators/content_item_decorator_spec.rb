RSpec.describe ContentItemDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(content_item) }

  let(:content_item) { instance_double(Core::Article, id: 'bob') }

  it { is_expected.to respond_to(:alternate_options) }
  it { is_expected.to respond_to(:canonical_url) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }

  describe '#alternate_options' do
    context 'when there are no alternates' do
      before { allow(content_item).to receive(:alternates) { [] } }

      it 'returns an empty hash' do
        expect(decorator.alternate_options).to be_a(Hash)
        expect(subject.alternate_options).to be_empty
      end
    end

    context 'when there are alternates' do
      before { allow(content_item).to receive(:alternates) { [alternate] } }

      let(:alternate) { double(hreflang: locale, url: url) }
      let(:locale) { double }
      let(:url) { double }

      it 'returns a hash of locale => url pairs' do
        expect(subject.alternate_options).to include(locale => url)
      end
    end
  end

  describe '#canonical_url' do
    before do
      allow(content_item.class).to receive_messages(to_s: 'core/content_item')
      allow(helpers).to receive_messages(content_item_url: '/content_items/bob')
    end

    it 'requests the path from the object with the name derived from the object class' do
      expect(helpers).to receive(:content_item_url)
      subject.canonical_url
    end

    it 'returns the path to the content_item' do
      expect(subject.canonical_url).to eq('/content_items/bob')
    end
  end

  describe '#content' do
    let(:content_item) do
      instance_double(Core::Article,
                      id:          'bob',
                      title:       'uncle-bob-is-richer-than-you',
                      description: 'uncle is rich',
                      body:        MultiJson.load(File.read(fixture))['body'])
    end

    let(:html) { Nokogiri::HTML(decorator.content) }

    context 'when the object body needs processing' do
      let(:fixture) { 'spec/fixtures/pawnbrokers-how-they-work.json' }

      it 'strips images from intro paragraphs' do
        expect(html.search(HTMLProcessor::INTRO_IMG)).to be_empty
      end

      it 'strips action email links' do
        expect(html.search(HTMLProcessor::ACTION_EMAIL)).to be_empty
      end

      it 'strips action forms' do
        expect(html.search(HTMLProcessor::ACTION_FORM)).to be_empty
      end
    end

    context 'when the object body contains a video embeded in an iframe' do
      let(:fixture) { 'spec/fixtures/responsive-video.json' }

      it 'wraps the content in a div[@class="video-wrapper"]' do
        nodes = html.search('//div[@class="video-wrapper"]/p/iframe' +
                              '[starts-with(@src, "https://www.youtube.com/embed")]')

        expect(nodes).to_not be_empty
      end

      it 'adds title to the iframe' do
        expect(html.search('//iframe[starts-with(@title, "Video")]')).to_not be_empty
      end
    end

    context 'when the object contains a table' do
      let(:fixture) { 'spec/fixtures/responsive-table.json' }

      it 'wraps the content in a div[@class="table-wrapper"]' do
        nodes = html.search('//div[@class="table-wrapper"]/table[@class="datatable-default"]')

        expect(nodes).to_not be_empty
      end
    end

    context 'when the object contains collapsible content' do
      let(:fixture) { 'spec/fixtures/collapsibe.json' }

      it 'strips collapse span' do
        expect(html.search(HTMLProcessor::COLLAPSIBLE_SPAN)).to be_empty
      end
    end
  end
end
