require 'core/entities/article'

RSpec.describe ArticleDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(article) }

  let(:article) { instance_double(Core::Article, id: 'bob') }

  it { is_expected.to respond_to(:alternate_options) }
  it { is_expected.to respond_to(:canonical_url) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }

  describe '#alternate_options' do
    context 'when there are no alternates' do
      before { allow(article).to receive(:alternates) { [] } }

      it 'returns an empty hash' do
        expect(decorator.alternate_options).to be_a(Hash)
        expect(subject.alternate_options).to be_empty
      end
    end

    context 'when there are alternates' do
      before { allow(article).to receive(:alternates) { [alternate] } }

      let(:alternate) { double(hreflang: locale, url: url) }
      let(:locale) { double }
      let(:url) { double }

      it 'returns a hash of locale => url pairs' do
        expect(subject.alternate_options).to include(locale => url)
      end
    end
  end

  describe '#canonical_url' do
    before { allow(helpers).to receive_messages(article_url: '/articles/bob') }

    it 'returns the path to the article' do
      expect(subject.canonical_url).to eq('/articles/bob')
    end
  end

  describe '#intro' do
    let(:fixture) { 'spec/fixtures/pawnbrokers-how-they-work.json' }
    let(:article) do
      instance_double(Core::Article,
                      id:          'bob',
                      title:       'uncle-bob-is-richer-than-you',
                      description: 'uncle is rich',
                      body:        MultiJson.load(File.read(fixture))['body'])
    end

    let(:processed_body) { Nokogiri::HTML(decorator.send(:processed_body)) }
    let(:html) { decorator.intro }

    it 'returns just the intro' do
      expect(html).to eql processed_body.search(HTMLProcessor::INTRO_PARAGRAPH).inner_html
    end
  end

  describe '#content' do
    let(:article) do
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

      it 'strips out the intro' do
        expect(html.search(HTMLProcessor::INTRO_PARAGRAPH)).to be_empty
      end
    end

    context 'when the object body contains a video embeded in an iframe' do
      let(:fixture) { 'spec/fixtures/responsive-video.json' }

      it 'wraps the content in a div[@class="video-wrapper"]' do
        nodes = html.search('//div[@class="video-wrapper"]/p/iframe' +
                              '[starts-with(@src, "https://www.youtube.com/embed")]')

        expect(nodes).to_not be_empty
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

  describe '#related_categories' do
    let(:article) { Core::Article.new('article A', categories: [category]) }
    let(:article_second_instance) { Core::Article.new('article A') }
    let(:second_article) { Core::Article.new('Article B') }
    let(:category) { Core::Category.new('test', contents: [article_second_instance, second_article]) }

    it "removes the original article from it's categories' contents" do
      expect(subject.related_categories.first.contents.map(&:object)).to_not include(article_second_instance)
    end

    it "retains the other article in it's categories' contents" do
      expect(subject.related_categories.first.contents.map(&:object)).to include(second_article)
    end

    context 'if a category has no contents' do
      let(:category) { Core::Category.new('test', contents: [article_second_instance]) }

      it 'is excluded from the results' do
        expect(subject.related_categories.map(&:object)).to_not include(category)
      end
    end
  end
end
