RSpec.describe ContentItemDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(content_item) }

  let(:content_item) do
    Mas::Cms::Article.new('borrow-money')
  end

  it { is_expected.to respond_to(:alternate_options) }
  it { is_expected.to respond_to(:canonical_url) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:id) }

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

  describe '#social_share_image' do
    let(:large_image) { 'http://comfy.mas/assets/debt-and-borrowing.png' }

    context 'when parent category has large image' do
      let(:category) { double(large_image: large_image) }

      before do
        expect(helpers).to receive(:parent_category).and_return(category)
      end

      it 'returns parent category large image' do
        expect(decorator.social_share_image).to eq(large_image)
      end
    end

    context 'when parent category does not have large image' do
      let(:category) { double(large_image: nil) }

      before do
        expect(helpers).to receive(:parent_category).and_return(category)
      end

      it 'returns mas logo' do
        expect(decorator.social_share_image).to include('MAS-logo_social-sharing.png')
      end
    end

    context 'when does not have parent category' do
      before do
        expect(helpers).to receive(:parent_category).and_return(nil)
      end

      it 'returns mas logo' do
        expect(decorator.social_share_image).to include('MAS-logo_social-sharing.png')
      end
    end
  end

  describe '#canonical_url' do
    before do
      allow(helpers).to receive(:article_url).with('borrow-money').and_return('/articles/borrow-money')
    end

    it 'requests the path from the object with the name derived from the object class' do
      expect(subject.canonical_url).to eq('/articles/borrow-money')
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

      it 'adds accesible attributes to headings' do
        html.search(HTMLProcessor::HEADINGS).each do |heading|
          expect(heading.attributes.keys).to include('role', 'aria-level')
        end
      end

      it 'adds the right aria-level to the heading attribute' do
        expect(html.search('//h2').attribute('aria-level').value).to eq('2')
      end
    end

    context 'when the object body contains a video embeded in an iframe' do
      let(:fixture) { 'spec/fixtures/responsive-video.json' }

      it 'wraps the content in a div[@class="video-wrapper"]' do
        nodes = html.search('//div[@class="video-wrapper"]/p/iframe' \
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
