require 'spec_helper'
require 'core/entities/article'

describe ArticleDecorator do

  let(:api_article) do
    MultiJson.load(File.read('spec/fixtures/pawnbrokers-how-they-work.json'))
  end

  let(:decorator)   { ArticleDecorator }

  let(:article)     do
    decorator.decorate(
      double(Core::Article,
        id:          'bob',
        title:       'uncle-bob-is-richer-than-you',
        description: 'uncle is rich',
        body:        api_article['body']))
  end

  describe '#content' do
    describe 'sanitizes HTML' do
      context 'With content than needs sanitizing' do
        it 'strips images from intro paragraphs' do
          filter_xml = Nokogiri::HTML(decorator.decorate(article).content).search(HTMLProcessor::INTRO_IMG)
          expect(filter_xml).to be_empty
        end

        it 'strips action email links' do
          filter_xml = Nokogiri::HTML(decorator.decorate(article).content).search(HTMLProcessor::ACTION_EMAIL)
          expect(filter_xml).to be_empty
        end

        it 'strips action forms' do
          filter_xml = Nokogiri::HTML(decorator.decorate(article).content).search(HTMLProcessor::ACTION_FORM)
          expect(filter_xml).to be_empty
        end

      end
    end
  end
end
