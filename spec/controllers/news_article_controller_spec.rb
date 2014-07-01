require 'core/interactors/news_article_reader'
require 'core/entities/news_article'

RSpec.describe NewsController, type: :controller do
  describe 'GET show' do
    let(:news_article) { instance_double(Core::NewsArticle, id: 'test') }
    let(:news_reader) { instance_double(Core::NewsArticleReader, call: news_article) }

    before { allow_any_instance_of(Core::NewsArticleReader).to receive(:call) { news_article } }

    it 'is succesful' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(response).to be_ok
    end

    it 'instantites an NewsArticleReader' do
      expect(Core::NewsArticleReader).to receive(:new).with(news_article.id) { news_reader }

      get :show, locale: I18n.locale, id: news_article.id
    end

    it 'assigns @news_article to the result of NewsArticleReader' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(assigns(:news_article)).to eq(news_article)
    end

    context 'when a news article does not exist' do

      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::NewsArticleReader).to receive(:call).and_yield

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
