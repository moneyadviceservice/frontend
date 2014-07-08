RSpec.describe NewsController, type: :controller do
  describe 'GET show' do
    let(:news_article) { instance_double(Core::NewsArticle, id: 'test', categories: []) }
    let(:news_reader) { instance_double(Core::NewsArticleReader, call: news_article) }
    let(:news_article_reader) { instance_double(Core::NewsArticleReader, call: news_article) }

    before do
      allow(Core::NewsArticleReader).to receive(:new) { news_reader }
      allow(Core::CategoryTreeReader).to receive(:new) { -> { double } }
    end

    it 'is succesful' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(response).to be_ok
    end

    it 'instantites an NewsArticleReader' do
      expect(Core::NewsArticleReader).to receive(:new).with(news_article.id) { news_article_reader }

      get :show, locale: I18n.locale, id: news_article.id
    end

    it 'assigns @news_article to the result of NewsArticleReader' do
      get :show, locale: I18n.locale, id: news_article.id

      expect(assigns(:news_article)).to eq(news_article)
    end

    context 'when a news article does not exist' do

      it 'raises an ActionController RoutingError' do
        allow(Core::NewsArticleReader).to receive(:new) { ->(&block) { block.call } }

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'GET index' do
    let(:news) { [] }
    let(:news_reader) { instance_double(Core::NewsReader, call: news) }

    before { allow_any_instance_of(Core::NewsReader).to receive(:call) { news } }

    it 'is succesful' do
      get :index, locale: I18n.locale

      expect(response).to be_ok
    end

    it 'instantites a NewsReader' do
      expect(Core::NewsReader).to receive(:new) { news_reader } { news_reader }

      get :index, locale: I18n.locale
    end

    it 'assigns @news to the result of NewsReader' do
      get :index, locale: I18n.locale

      expect(assigns(:news)).to eq(news)
    end

    context 'when news index does not exist' do
      it 'raises an ActionController RoutingError' do
        allow_any_instance_of(Core::NewsReader).to receive(:call).and_yield

        expect { get :index, locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
