require 'core/entities/news_article'

RSpec.describe NewsArticleDecorator do

  subject(:decorator) { described_class.decorate(news_article) }

  let(:news_article) { Core::NewsArticle.new('news_article_id') }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:date) }

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

  describe '#date' do
    let(:attributes) { { date: '2014-03-17T09:42:11+00:00' } }
    let(:news_article) { Core::NewsArticle.new('news_article_id', attributes) }

    it 'formats the date' do
      expect(decorator.date).to eq('17 Mar 2014')
    end
  end
end
