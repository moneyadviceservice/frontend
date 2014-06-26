require 'core/entities/news_article'

RSpec.describe NewsArticleDecorator do

  subject(:decorator) { described_class.decorate(news_article) }

  let(:news_article) { Core::NewsArticle.new('news_article_id') }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:content) }

  describe '#content' do
    let(:fixture) { 'spec/fixtures/news_article.json' }
    let(:attributes) do
      {
        title:        'news aticle title',
        description:  'news article description',
        body:         MultiJson.load(File.read(fixture))['body']
      }
    end

    let(:news_article) { Core::NewsArticle.new('news_article_id', attributes) }
    let(:html) { Nokogiri::HTML(decorator.content) }

    it 'removes the image author paragraph' do
      expect(html.search(HTMLProcessor::IMAGE_AUTHOR)).to be_empty
    end
  end
end
