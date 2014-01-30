require 'spec_helper'
require 'core/entities/article'

describe ArticleDecorator do
  let(:api_article) do
    MultiJson.load(File.read('spec/fixtures/pawnbrokers-how-they-work.json'))
  end

  let(:decorator) { ArticleDecorator }

  let(:article) do
    decorator.decorate(
      double(Core::Article,
             id:          'bob',
             title:       'uncle-bob-is-richer-than-you',
             description: 'uncle is rich',
             body:        api_article['body']))
  end

  describe '#content' do
    describe 'sanitizes HTML' do
      context 'with content than needs sanitizing' do
        let(:html) { Nokogiri::HTML(decorator.decorate(article).content) }

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
    end
  end
end
