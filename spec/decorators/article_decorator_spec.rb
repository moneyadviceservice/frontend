require 'spec_helper'
require 'core/entities/article'

describe ArticleDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(article) }

  let(:article) { double(Core::Article, id: 'bob') }

  it { should respond_to(:alternate_options) }
  it { should respond_to(:canonical_url) }
  it { should respond_to(:content) }
  it { should respond_to(:description) }
  it { should respond_to(:title) }

  describe '#alternate_options' do
    before { allow(article).to receive(:alternate) { alternate } }

    context 'when there is no alternate' do
      let(:alternate) { nil }

      it 'returns an empty hash' do
        expect(decorator.alternate_options).to be_a(Hash)
        expect(subject.alternate_options).to be_empty
      end
    end

    context 'when there is an alternate' do
      let(:alternate) { double(hreflang: locale, url: url) }
      let(:locale) { double }
      let(:url) { double }

      it 'returns a hash of locale => url pairs' do
        expect(subject.alternate_options).to include(locale => url)
      end
    end
  end

  describe '#content' do
    let(:article) do
      double(Core::Article,
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
